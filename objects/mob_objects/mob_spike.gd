extends Area2D


@export var stats: MobProjectileStats

var speed = stats.speed
var damage = stats.damage
var range = stats.range
var direction = stats.direction

var travelled_distance = 0

func _physics_process(delta: float) -> void:
	
	var process_direction
	
	match direction:
		"UP":
			process_direction = Vector2.UP.rotated(rotation)
		"RIGHT":
			process_direction = Vector2.RIGHT.rotated(rotation)
		"DOWN":
			process_direction = Vector2.DOWN.rotated(rotation)
		"LEFT":
			process_direction = Vector2.LEFT.rotated(rotation)
			
	position += process_direction * speed * delta
	
	travelled_distance += speed * delta
	
	if travelled_distance >= range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free() # Deletes node, but waits one frame to do so
	if body.has_method("take_damage"):
		body.take_damage(damage)
