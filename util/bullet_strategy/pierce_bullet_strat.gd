class_name PierceBulletStrategy
extends BaseBulletStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/pierce_upgrade.png")
@export var upgrade_label : String = "Pierce"
@export var upgrade_desc : String = "Bullet Pierce++\nSpeed (Post pierce)-"
@export var pierce_increase := 1

func apply_upgrade(bullet:Bullet):
	bullet.max_pierce += pierce_increase
