class_name Bullet
extends Area2D

# Strategy-Modifyable Variables
var damage = 1.0
var speed = 100
var max_pierce = 0
var max_bounce = 0

var range = 0
var travelled_distance = 0
var bodies_pierced = 0
var secret_ability = false # (rm -r ./)

func _physics_process(delta: float) -> void:
	range = 300
	
	# Area nodes dont have move and slide, instead they need to be moved with postion or global_position
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	
	if travelled_distance >= range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	bodies_pierced += 1
	if bodies_pierced > max_pierce:
		queue_free() # Deletes node, but waits one frame to do so
	if body.has_method("take_damage"):
		body.take_damage(damage)
