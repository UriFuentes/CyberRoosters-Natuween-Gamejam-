extends Area2D

signal upgrade_selected

@export var upgrade_label : Label
@export var upgrade_desc : RichTextLabel
@export var sprite : Sprite2D
@export var upgrade_strategy : BaseUpgradeStrategy:
	set(val):
		upgrade_strategy = val

func _ready() -> void:
	sprite.texture = upgrade_strategy.texture
	upgrade_label.text = upgrade_strategy.upgrade_label
	upgrade_desc.text = upgrade_strategy.upgrade_desc
	
func set_upgrade_type(strategy):
	upgrade_strategy = strategy
	sprite.texture = upgrade_strategy.texture
	upgrade_label.text = upgrade_strategy.upgrade_label
	upgrade_desc.text = upgrade_strategy.upgrade_desc

func _on_select_button_pressed() -> void:
	print("Pressed")
	upgrade_selected.emit()
	
