extends Area2D

signal upgrade_selected

@export var upgrade_label : Label
@export var upgrade_desc : RichTextLabel
@export var sprite : Sprite2D
@export var bullet_strategy : BaseBulletStrategy:
	set(val):
		bullet_strategy = val
		needs_update = true
		
# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update := false

func _ready() -> void:
	sprite.texture = bullet_strategy.texture
	upgrade_label.text = bullet_strategy.upgrade_label
	upgrade_desc.text = bullet_strategy.upgrade_desc
	
func set_upgrade_type(strategy):
	bullet_strategy = strategy
	sprite.texture = bullet_strategy.texture
	upgrade_label.text = bullet_strategy.upgrade_label
	upgrade_desc.text = bullet_strategy.upgrade_desc

func _on_select_button_pressed() -> void:
	print("Pressed")
	upgrade_selected.emit()
	
