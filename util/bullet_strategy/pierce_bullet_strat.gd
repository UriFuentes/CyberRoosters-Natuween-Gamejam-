class_name PierceBulletStrategy
extends BaseBulletStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/pierce_upgrade.png")
@export var upgrade_text : String = "Pierce"
@export var pierce_increase := 1

func apply_upgrade(bullet:Bullet):
	bullet.pierce += pierce_increase
