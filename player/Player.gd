class_name Player
extends CharacterBody2D

signal health_depleted
signal level_up

var health = 100.0
var max_health = 100.0
var speed = 150

var xp = 0
var next_level_xp = 10 # Starting value
var bullet_upgrades : Array[BaseUpgradeStrategy] # Holds Bullet strategy upgrades
var player_upgrades = 0 # Holds Player bullet strategies

var damage_sfx_cooldown := 0.2  # seconds between sound plays
var damage_sfx_timer := 0.0

@onready var pistol_firerate_timer = $Pistol/FireRate

func _physics_process(delta: float) -> void:
	# Movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	# Animation
	if velocity.length() > 0:
		%PlayerAnimation.play("player_walk")
	else:
		%PlayerAnimation.play("player_idle")
	
	# Melee Damage
	damage_sfx_timer -= delta
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size():
		for mob in overlapping_mobs:
			if damage_sfx_timer <= 0.0:
				%DamageSFX.play()
				damage_sfx_timer = damage_sfx_cooldown
			
			health -= mob.DAMAGE_OUTPUT_MELEE * delta
			%HealthBar.value = health
			if health <= 0.0:
				health_depleted.emit()

	# Leveling Up
	if xp >= next_level_xp:
		level_up.emit() # Signal to level_system.gd
		next_level_xp = ( next_level_xp + 10 ) * 1.1
		

###### Damage Types ######
func take_damage_over_time(dmg):
	health -= dmg * get_physics_process_delta_time() 
	%HealthBar.value = health
	if health <= 0.0:
		health_depleted.emit()


func take_damage_instant(dmg):
	%DamageSFX.play()
	health -= dmg
	%HealthBar.value = health
	if health <= 0.0:
		health_depleted.emit()


###### Lootables ######
func gain_xp(x):
	xp += x
	%PlayerXP.set_text("Print(XP)\n  > " + str(xp))


func gain_health(x) -> void:
	health = clamp(health + x, 0, max_health)
	%HealthBar.value = health
	
	
###### Upgrades ######
func incr_max_health(increase) -> void:
	max_health += increase
	%HealthBar.max_value = max_health
	health += increase
	

func change_firerate(scale) -> void:
	pistol_firerate_timer.wait_time -= pistol_firerate_timer.wait_time * scale


func add_upgrade(upgrade) -> void:
	bullet_upgrades.append(upgrade)


func _on_level_up_screen_apply_player_upgrade() -> void:
	player_upgrades.apply_bullet_upgrade(self)
	
