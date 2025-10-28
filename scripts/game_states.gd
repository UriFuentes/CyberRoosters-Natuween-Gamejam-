extends CanvasLayer


var time_paused := 0

@onready var PlayerInfo = %PlayerInfo

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused: # Unpause
			get_tree().paused = false
			%GamePaused.visible = false
			%BackgroundMusic.pitch_scale = lerp(%BackgroundMusic.pitch_scale, 1.0, 0.1)
		else: # Pause
			get_tree().paused = true
			%GamePaused.visible = true
			%BackgroundMusic.pitch_scale = lerp(%BackgroundMusic.pitch_scale, 0.6, 0.1)


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cyberooster.tscn")


func _on_elapsed_timer_timeout() -> void:
	if get_tree().paused:
		time_paused += 1
