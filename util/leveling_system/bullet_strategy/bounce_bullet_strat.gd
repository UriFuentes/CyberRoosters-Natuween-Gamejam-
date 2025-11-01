class_name BounceBulletStrategy
extends BaseUpgradeStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/bullet/bounce_upgrade.png")
@export var upgrade_label : String = "Bounce"
@export var upgrade_desc : String = "Bullet Bounce+\nBullet damage-"
@export var bounce_increase := 1

func apply_bullet_upgrade(bullet:Bullet):
	bullet.max_bounce += bounce_increase
