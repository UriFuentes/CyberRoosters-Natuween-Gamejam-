extends CanvasLayer


@onready var music_pitch =  %BackgroundMusic.pitch_scale

func pause_game() -> void:
	if get_tree().paused: # Unpause
			get_tree().paused = false
			%BackgroundMusic.pitch_scale = lerp(music_pitch, 1.0, 0.1)
	else: # Pause
		get_tree().paused = true
		%BackgroundMusic.pitch_scale = lerp(music_pitch, 0.3, 0.1)


# GAME PAUSED
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		%GamePaused.visible = not %GamePaused.visible
		pause_game()

# GAME OVER
func _on_player_health_depleted() -> void:
	pause_game()
	%GameOver.visible = true
	%BackgroundMusic.pitch_scale = lerp(%BackgroundMusic.pitch_scale, 0.6, 0.1)
	Global.kill_player(%Player)
	
# GAME WIN
func _on_game_won() -> void:
	%GameWon.visible = true
	%VictorySFX.play()
	pause_game() # pause

func _on_restart_button_pressed() -> void:
	pause_game() # unpause
	get_tree().change_scene_to_file("res://cyberooster.tscn")
