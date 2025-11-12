extends Area2D



@onready var HealSFX = $/root/Game/Player/HealSFX

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_method("gain_health"):
		var heal_amount = body.max_health * 0.2
		body.gain_health(heal_amount)
		HealSFX.play()
		queue_free()
		
