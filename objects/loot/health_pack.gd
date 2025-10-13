extends Area2D


const HEALTH = 10.0

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_method("gain_health"):
		queue_free()
		body.gain_health(HEALTH)
	
