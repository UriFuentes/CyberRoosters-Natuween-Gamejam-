extends Area2D

const DAMAGE = 33.0

func _ready() -> void:
	%ExplosionSFX.play()


func _on_body_entered(body: Node2D) -> void:
	queue_free() # Deletes node, but waits one frame to do so
	if body.has_method("take_damage_instant"):
		body.take_damage_instant(DAMAGE)


func _on_life_span_timeout() -> void:
	queue_free()
