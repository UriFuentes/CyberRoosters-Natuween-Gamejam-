extends Area2D


@export var upgrade_label : Label
@export var sprite : Sprite2D
@export var bullet_strategy : BaseBulletStrategy:
	set(val):
		bullet_strategy = val
		needs_update = true
		
# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update := false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	sprite.texture = bullet_strategy.texture
	upgrade_label.text = bullet_strategy.upgrade_text
	
func set_upgrade_type(strategy):
	bullet_strategy = strategy
	sprite.texture = bullet_strategy.texture
	upgrade_label.text = bullet_strategy.upgrade_text

func on_body_entered(body: PhysicsBody2D):
	if body is Player:
		body.upgrades.append(bullet_strategy)
		queue_free()
