extends CharacterBody2D

signal health_depleted
signal level_up

var health = 100.0
var max_health = 100.0
var speed = 150
var xp = 0
var next_level_xp = 20

var upgrades : Array[BaseBulletStrategy]

@onready var infolabel = %PlayerXP

func _physics_process(delta: float) -> void:
	# Movement
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	# Melee Damage
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size():
		for mob in overlapping_mobs:
			health -= mob.DAMAGE_OUTPUT * delta
			%HealthBar.value = health
			if health <= 0.0:
				health_depleted.emit()
				
	# Leveling Up
	if xp >= next_level_xp:
		level_up.emit()
	

# Writing a function like this for players, since different enemies have different damage
func take_damage_over_time(dmg):
	health -= dmg * get_physics_process_delta_time() 
	%HealthBar.value = health
	if health <= 0.0:
			health_depleted.emit()

func take_damage_instant(dmg):
	health -= dmg
	%HealthBar.value = health
	if health <= 0.0:
			health_depleted.emit()

func gain_xp(x):
	xp += x
	%PlayerXP.set_text("Print(XP)\n  > " + str(xp))
	
func gain_health(x):
	health = clamp(health + x, 0, max_health)
	%HealthBar.value = health

func _on_level_up() -> void:
	get_tree().paused = true
	%LevelUpScreen.visible = true
	
func add_upgrade(upgrade) -> void:
	upgrades.append(upgrade)
	
