extends Node2D

var start_time
var current_time

func _ready() -> void:
	start_time  = Time.get_unix_time_from_system()
	
#func _process(delta: float) -> void:
	#current_time = Time.get_unix_time_from_system()
	#%ElapsedTime.set_text(current_time - start_time)

func spawn_mob():
	var new_mob = preload("res://characters/mobs/virus_1A.tscn").instantiate()
	%SpawnPath.progress_ratio = randf()
	new_mob.global_position = %SpawnPath.global_position
	add_child(new_mob)

func _on_spawn_timer_timeout() -> void:
	spawn_mob()
	
func convert_time_MMSS(time):
	var minutes = time / 60
	var seconds = time % 60
	return "%02d:%02d" % [minutes, seconds]
	
func _on_elapsed_timer_timeout() -> void:
	current_time = Time.get_unix_time_from_system()
	var formatted_time = convert_time_MMSS(int(round(current_time - start_time)))
	%ElapsedTime.set_text(formatted_time)


#func _on_player_health_depleted() -> void:
	#%GameOver.visible = true
	#get_tree().paused = true
