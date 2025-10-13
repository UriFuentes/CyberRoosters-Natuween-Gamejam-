extends Area2D


const DAMAGE = 1.0
var travelled_distance = 0

func _physics_process(delta: float) -> void:
	const SPEED = 100
	const RANGE = 300
	
	# Area nodes dont have move and slide, instead they need to be moved with postion or global_position
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	
	if travelled_distance >= RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free() # Deletes node, but waits one frame to do so
	if body.has_method("take_damage"):
		body.take_damage(DAMAGE)
