extends Area2D

var damage = 50.0

func _on_body_entered(body: Node2D) -> void:
	queue_free() # Deletes node, but waits one frame to do so
	if body.has_method("take_damage_instant"):
		body.take_damage_instant(damage)


func _on_life_span_timeout() -> void:
	queue_free()
