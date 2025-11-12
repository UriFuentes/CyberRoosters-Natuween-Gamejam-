class_name HealthPlayerStrategy
extends BaseUpgradeStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/player/player_health_upgrade.png")
@export var upgrade_label : String = "Max Health"
@export var upgrade_desc : String = "Player Max Health++\nPlayer Health++"
@export var health_increase := 25

func apply_player_upgrade(player:Player):
	print("Old max health: ", player.max_health)
	player.incr_max_health(health_increase)
	print("New max health: ", player.max_health)
	
