extends Area2D

@onready var player = get_owner()

var enemies_in_range
var target_enemy

func _physics_process(delta: float) -> void:
	enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	const BULLET = preload("res://objects/weapons/bullet.tscn") # Loads bullet at star of the game
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootPoint.global_position # Puts the bullet in the shooting point postion
	new_bullet.global_rotation = %ShootPoint.global_rotation 
	%ShootPoint.add_child(new_bullet)
	
	# Add Strategy Upgrades
	for strategy in player.upgrades:
		strategy.apply_upgrade(new_bullet)

func _on_timer_timeout() -> void:
	shoot()
