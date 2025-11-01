class_name SpeedPlayerStrategy
extends BaseUpgradeStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/player/player_speed_upgrade.png")
@export var upgrade_label : String = "Speed"
@export var upgrade_desc : String = "Player Speed++\n"
@export var speed_increase := 0.15 # 15 %

func apply_player_upgrade(player:Player):
	print("Old speed: ", player.speed)
	player.speed += player.speed * speed_increase
	print("New speed: ", player.speed)
	
