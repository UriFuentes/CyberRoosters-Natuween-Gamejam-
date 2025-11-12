class_name FireratePlayerStrategy
extends BaseUpgradeStrategy

@export var texture : Texture2D = preload("res://util/leveling_system/upgrade_sprites/player/player_firerate_upgrade.png")
@export var upgrade_label : String = "Fire Rate"
@export var upgrade_desc : String = "Gun Fire Rate++\n"
@export var firerate_increase := 0.18 # 20 %

func apply_player_upgrade(player:Player):
	print("Old fire rate: ", player.pistol_firerate_timer.wait_time)
	player.change_firerate(firerate_increase)
	print("New fire rate: ", player.pistol_firerate_timer.wait_time)
	
