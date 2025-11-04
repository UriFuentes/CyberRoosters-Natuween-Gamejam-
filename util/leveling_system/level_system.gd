extends Node2D

signal upgrade_chosen(index)
signal apply_player_upgrade

var selected := -1 # (Null value)

@onready var player = %Player

func _on_player_level_up() -> void:
	get_tree().paused = true
	visible = true
	%LevelUpSFX.play()
	
	# Load Resource files for bullet upgrades
	const DAMAGE_BULLET_STRATEGY := preload("res://util/leveling_system/bullet_strategy/damage_bullet.tres")
	const SPEED_BULLET_STRATEGY := preload("res://util/leveling_system/bullet_strategy/speed_bullet.tres")
	const BOUNCE_BULLET_STRATEGY := preload("res://util/leveling_system/bullet_strategy/bounce_bullet.tres")
	const PIERCE_BULLET_STRATEGY := preload("res://util/leveling_system/bullet_strategy/pierce_bullet.tres")
	# Load Resource files for player upgrades
	const SPEED_PLAYER_STRATEGY := preload("res://util/leveling_system/player_strategy/speed_player.tres")
	const HEALTH_PLAYER_STRATEGY := preload("res://util/leveling_system/player_strategy/health_player.tres")
	const FIRERATE_PLAYER_STRATEGY := preload("res://util/leveling_system/player_strategy/firerate_player.tres")

	# Generate 3 random upgrades to select from
	var upgrade_selection := []
	for i in range(3):
		var upgrade_type := 0
		var upgrade
		while true:
			upgrade_type = randi_range(1,7)
			match upgrade_type:
				1: upgrade = DAMAGE_BULLET_STRATEGY
				2: upgrade = SPEED_BULLET_STRATEGY
				3: upgrade = BOUNCE_BULLET_STRATEGY
				4: upgrade = PIERCE_BULLET_STRATEGY
				5: upgrade = SPEED_PLAYER_STRATEGY
				6: upgrade = HEALTH_PLAYER_STRATEGY
				7: upgrade = FIRERATE_PLAYER_STRATEGY
			if upgrade not in upgrade_selection: # Avoids duplicates
				break
				
		upgrade_selection.append(upgrade)
	
	# Assign upgrades to upgrade nodes
	var i := 0
	for node in get_children():
		if node is not Area2D:
			continue
		else:
			node.set_upgrade_type(upgrade_selection[i])
			i += 1

	await self.upgrade_chosen
	
	#### Following code will ONLY run when player has pressed a select button ####
	%UpgradeSelectSFX.play()
	
	# This is detecting the class, so itll see both methods, find a way to siolate this 
	
	if upgrade_selection[selected].has_method("apply_bullet_upgrade"):
		player.bullet_upgrades.append(upgrade_selection[selected])
		print("Upgraded Bullet")
	elif upgrade_selection[selected].has_method("apply_player_upgrade"):
		player.player_upgrades = upgrade_selection[selected]
		player.player_upgrades.apply_player_upgrade(player)
		print("Upgraded player")
	
		emit_signal("apply_player_upgrade")
	
	visible = false
	get_tree().paused = false
	
	
func _on_upgrade_1_selected():
	selected = 0
	emit_signal("upgrade_chosen", selected)

func _on_upgrade_2_selected():
	selected = 1
	emit_signal("upgrade_chosen", selected)
	
func _on_upgrade_3_selected():
	selected = 2
	emit_signal("upgrade_chosen", selected)
	
