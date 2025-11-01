extends Area2D

@onready var player = get_owner()
@onready var BulletImpactSFX = %BulletImpactSFX

var enemies_in_range
var target_enemy

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var closest_enemy = null
		var closest_distance = INF

		for enemy in enemies_in_range:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = enemy

		if closest_enemy:
			look_at(closest_enemy.global_position)

func shoot():
	const BULLET = preload("res://objects/weapons/bullet.tscn") # Loads bullet at star of the game
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootPoint.global_position # Puts the bullet in the shooting point postion
	new_bullet.global_rotation = %ShootPoint.global_rotation 
	%ShootPoint.add_child(new_bullet)
	
	# Add Strategy Upgrades
	for strategy in player.bullet_upgrades:
		strategy.apply_bullet_upgrade(new_bullet)
		
	%GunSFX.play()

func _on_timer_timeout() -> void:
	shoot()
