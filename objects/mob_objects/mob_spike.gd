extends Area2D

var damage = 20.0
 
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage_instant"):
		body.take_damage_instant(damage)
