extends CharacterBody2D


var health = 3.0
const DAMAGE_OUTPUT_MELEE = 10.0
const DAMAGE_OUTPUT_RANGE = 20.0
var speed = 100

@onready var player = get_tree().get_root().get_node("Game/Player") # Onready checks if player is available

const SPIKES = [preload("res://objects/mob_objects/spike_UP.tres"),
				preload("res://objects/mob_objects/spike_RIGHT.tres"),
				preload("res://objects/mob_objects/spike_DOWN.tres"),
				preload("res://objects/mob_objects/spike_LEFT.tres")]

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	
func take_damage(x):
	health -= x
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
	
func shoot_spikes():
	var i = 0
	for SpikeSpawn in get_children():
		if SpikeSpawn is Marker2D:
			var new_spike = SPIKES[i].instantiate()
			new_spike.global_position = SpikeSpawn.global_position 
			new_spike.global_rotation = SpikeSpawn.global_rotation 
			SpikeSpawn.add_child(new_spike)
			i += 1

func _on_spike_cooldown_timeout() -> void:
	shoot_spikes()
