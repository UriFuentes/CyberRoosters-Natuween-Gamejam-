class_name DamageBulletStrategy
extends BaseBulletStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/damage_upgrade.png")
@export var upgrade_label : String = "Damage"
@export var upgrade_desc : String = "Bullet damage++"
@export var damage_increase := 1.0

func apply_upgrade(bullet:Bullet):
	bullet.damage += damage_increase
