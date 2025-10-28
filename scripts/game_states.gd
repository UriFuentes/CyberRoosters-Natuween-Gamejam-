extends CanvasLayer


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cyberooster.tscn")
