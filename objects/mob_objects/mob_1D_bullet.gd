extends Area2D

var damage = 30.0
var speed = 200
var range = 600
var travelled_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance >= range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage_instant"):
		body.take_damage_instant(damage)
