extends Area2D


const XP = 1

@onready var XpSFX = $/root/Game/Player/XpSFX

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.has_method("gain_xp"):
		queue_free()
		XpSFX.play()
		body.gain_xp(XP)
	
