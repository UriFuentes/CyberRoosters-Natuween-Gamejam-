extends Player


var current_level = 1


###### Leveling up and Upgrades ######
func _on_player_level_up() -> void:
	get_tree().paused = true
	%LevelUpBkg.visible = true
	
func add_upgrade(upgrade) -> void:
	upgrades.append(upgrade)
