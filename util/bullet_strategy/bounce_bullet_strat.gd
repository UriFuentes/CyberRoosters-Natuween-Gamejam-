class_name BounceBulletStrategy
extends BaseBulletStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/bounce_upgrade.png")
@export var upgrade_text : String = "Bounce"
@export var bounce_increase := 1

func apply_upgrade(bullet:Bullet):
	bullet.bounce += bounce_increase
