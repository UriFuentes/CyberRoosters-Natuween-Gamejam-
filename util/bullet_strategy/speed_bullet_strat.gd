class_name SpeedBulletStrategy
extends BaseBulletStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/speed_upgrade.png")
@export var upgrade_label : String = "Speed"
@export var upgrade_desc : String = "Bullet speed++"
@export var speed_increase := 15

func apply_upgrade(bullet:Bullet):
	bullet.speed += speed_increase
