class_name Bullet
extends Area2D

# Strategy-Modifyable Variables
var damage = 1.0
var speed = 100
var max_pierce = 0
var max_bounce = 0
var velocity := Vector2.ZERO
var range = 700
var travelled_distance = 0
var bodies_pierced = 0
var bodies_bounced = 0
var has_bounced = false

#var secret_ability = false # (rm -r ./)

@onready var BulletImpactSFX = $/root/Game/Player/Pistol/BulletImpactSFX

func _ready() -> void:
	velocity = Vector2.RIGHT.rotated(rotation) * speed

func _physics_process(delta: float) -> void:
	# Area nodes dont have move and slide, instead they need to be moved with postion or global_position
	position += velocity * delta
	travelled_distance += velocity.length() * delta

	if travelled_distance >= range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	BulletImpactSFX.play()

	if body.has_method("take_damage_instant"):
		body.take_damage_instant(damage)

	# Bounce logic
	if bodies_pierced != max_pierce:
		bodies_pierced += 1
	else:
		var space_state = get_world_2d().direct_space_state
		var ray_params := PhysicsRayQueryParameters2D.new()
		ray_params.from = global_position - velocity.normalized() * 4
		ray_params.to = global_position + velocity.normalized() * 4
		ray_params.exclude = [self]
		ray_params.collision_mask = collision_mask  # Optional, only if you're using layers

		var collision = space_state.intersect_ray(ray_params)

		if collision:
			var normal = collision.normal
			velocity = velocity.bounce(normal)
		
		bodies_bounced += 1
		
		if bodies_bounced > max_bounce:
			queue_free()
			return
	
