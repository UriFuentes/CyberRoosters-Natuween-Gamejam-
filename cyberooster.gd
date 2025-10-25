extends Node2D

var start_time
var current_time

var minutes = 0

func _ready() -> void:
	start_time  = Time.get_unix_time_from_system()
	
#func _process(delta: float) -> void:
	#current_time = Time.get_unix_time_from_system()
	#%ElapsedTime.set_text(current_time - start_time)

func spawn_mob():
	var new_mob
	if minutes <= 1:
		new_mob = preload("res://characters/mobs/virus_1A.tscn").instantiate()
	elif minutes <= 2:
		var r = randi_range(1,10)
		if r <= 7:
			new_mob = preload("res://characters/mobs/virus_1A.tscn").instantiate()
		else:
			new_mob = preload("res://characters/mobs/virus_1B.tscn").instantiate()
	elif minutes <= 4:
		var r = randi_range(1,10)
		if r <= 5:
			new_mob = preload("res://characters/mobs/virus_1A.tscn").instantiate()
		else:
			new_mob = preload("res://characters/mobs/virus_1B.tscn").instantiate()
	
	%SpawnPath.progress_ratio = randf()
	new_mob.global_position = %SpawnPath.global_position
	add_child(new_mob)

func _on_spawn_timer_timeout() -> void:
	spawn_mob()

func convert_time_MMSS(time):
	minutes = time / 60
	var seconds = time % 60
	return "%02d:%02d" % [minutes, seconds]
	
func _on_elapsed_timer_timeout() -> void:
	current_time = Time.get_unix_time_from_system()
	var formatted_time = convert_time_MMSS(int(round(current_time - start_time)))
	%ElapsedTime.set_text(formatted_time)

func _on_spawn_increment_timeout() -> void:
	%SpawnTimer.wait_time = clamp(%SpawnTimer.wait_time - 0.1, 0.1, 1)
	
	
#func _on_player_health_depleted() -> void:
	#%GameOver.visible = true
	#get_tree().paused = true
