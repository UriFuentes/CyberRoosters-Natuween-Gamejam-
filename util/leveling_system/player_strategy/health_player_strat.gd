class_name HealthPlayerStrategy
extends BaseUpgradeStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/player/player_health_upgrade.png")
@export var upgrade_label : String = "Health"
@export var upgrade_desc : String = "Player Health++\n"
@export var health_increase := 25

func apply_player_upgrade(player:Player):
	print("Old max health: ", player.max_health)
	player.max_health += health_increase
	player.health += health_increase
	print("New max health: ", player.max_health)
	
