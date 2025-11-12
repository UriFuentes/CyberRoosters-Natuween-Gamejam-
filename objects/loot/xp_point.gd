class_name xpPoint
extends Area2D


const XP = 1
var is_collected = false

var speed = 800
var velocity = null

@onready var XpSFX = $/root/Game/Player/XpSFX
@onready var player = $/root/Game/Player

func _physics_process(delta: float) -> void:
	if is_collected:
		move_to_player()

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_method("gain_xp"):
		queue_free()
		XpSFX.play()
		body.gain_xp(XP)
	
func move_to_player() -> void:
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	position += velocity * get_physics_process_delta_time()
	look_at(player.global_position)
	
