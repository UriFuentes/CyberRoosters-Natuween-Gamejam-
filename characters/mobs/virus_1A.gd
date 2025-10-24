extends CharacterBody2D

signal damage_particles
var particle_direction

var health = 3.0
const DAMAGE_OUTPUT_MELEE = 10.0
const DAMAGE_OUTPUT_RANGE = 20.0
var speed = 90

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
		queue_free()
		drop_loot()
	
func drop_loot():
	# Create random loot drop
	var drop_num = randi_range(1, 10)
	var new_drop 
		
	if drop_num <= 9: # 90% chance to drop XP
		new_drop = preload("res://objects/loot/xp_point.tscn").instantiate()
	else: # 10% chance to drop Health
		new_drop = preload("res://objects/loot/health_pack.tscn").instantiate()
		
	new_drop.global_position = global_position
	add_sibling(new_drop)	
	

func _on_damage_particles() -> void:
	particle_direction = (player.global_position - global_position).normalized()
	HitParticles.direction = -particle_direction
	HitParticles.emitting = true
	
