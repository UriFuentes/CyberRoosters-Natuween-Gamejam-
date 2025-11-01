class_name SpeedBulletStrategy
extends BaseUpgradeStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/bullet/speed_upgrade.png")
@export var upgrade_label : String = "Velocity"
@export var upgrade_desc : String = "Bullet velocity++"
@export var speed_increase := 15

func apply_bullet_upgrade(bullet:Bullet):
	bullet.speed += speed_increase
