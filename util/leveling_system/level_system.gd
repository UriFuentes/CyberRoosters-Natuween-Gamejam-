extends Node2D

signal upgrade_chosen(index)

var selected := -1 # (Null value)

@onready var player = %Player

func _on_player_level_up() -> void:
	get_tree().paused = true
	visible = true
	
	# Load Resource files for upgrades
	const DAMAGE_STRATEGY := preload("res://util/bullet_strategy/damage_bullet.tres")
	const SPEED_STRATEGY := preload("res://util/bullet_strategy/speed_bullet.tres")
	const BOUNCE_STRATEGY := preload("res://util/bullet_strategy/bounce_bullet.tres")
	const PIERCE_STRATEGY := preload("res://util/bullet_strategy/pierce_bullet.tres")

	# Generate 3 random upgrades to select from
	var upgrade_selection := []
	for i in range(3):
		var upgrade_type := 0
		var upgrade
		while true:
			upgrade_type = randi_range(1,4)
			match upgrade_type:
				1: upgrade = DAMAGE_STRATEGY
				2: upgrade = SPEED_STRATEGY
				3: upgrade = BOUNCE_STRATEGY
				4: upgrade = PIERCE_STRATEGY
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
	
	player.upgrades.append(upgrade_selection[selected])
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
	
