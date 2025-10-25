extends CharacterBody2D

signal damage_particles
var particle_direction

var health = 4.0
const DAMAGE_OUTPUT_MELEE = 15.0
var speed = 130

@onready var player = get_tree().get_root().get_node("Game/Player") # Onready checks if player is available
@onready var HitParticles = %HitParticles


func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
func take_damage_instant(x):
	health -= x
	emit_signal("damage_particles")
	if health <= 0:
		queue_free() # Remove the mob
		var new_explosion = preload("res://objects/mob_objects/explosion.tscn").instantiate()
		new_explosion.global_position = global_position  # Set explosion at mob's location
		add_sibling(new_explosion)           # Add explosion to the scene
		drop_loot()
	
func drop_loot():
	# Create random loot drop
	var drop_num = randi_range(1, 10)
	var new_drop 
		
	if drop_num <= 8: # 80% chance to drop XP
		new_drop = preload("res://objects/loot/xp_point.tscn").instantiate()
	else: # 10% chance to drop Health
		new_drop = preload("res://objects/loot/health_pack.tscn").instantiate()
		
	new_drop.global_position = global_position
	add_sibling(new_drop)	
	
func _on_damage_particles() -> void:
	particle_direction = (player.global_position - global_position).normalized()
	HitParticles.direction = -particle_direction
	HitParticles.emitting = true
