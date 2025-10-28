extends Node2D


var elapsed_time := 0
var minutes := 0

	
func _process(delta: float) -> void:
	if minutes == 8:
		%GameWon.visible = true
		%VictorySFX.play()
		get_tree().paused = true
		
	
const MOB_WEIGHTS := {
	1: { "virus_1A": 1.0 },
	2: { "virus_1A": 0.8, "virus_1B": 0.2 },
	4: { "virus_1A": 0.6, "virus_1B": 0.2, "virus_1C": 0.2 },
	6: { "virus_1A": 0.5, "virus_1B": 0.1, "virus_1C": 0.2, "virus_1D": 0.1 }
}

@onready var spawn_timer := %SpawnTimer
var extra_timers := []
	
func get_weighted_mob(minutes: int) -> PackedScene:
	var tier := 1
	
	var sorted_keys := MOB_WEIGHTS.keys()
	sorted_keys.sort()

	for t in sorted_keys:
		if minutes <= t:
			tier = t
			break

	var weights = MOB_WEIGHTS[tier]
	var total := 0.0
	for w in weights.values():
		total += w

	var roll := randf() * total
	var cumulative := 0.0
	
	for name in weights.keys():
		cumulative += weights[name]
		if roll <= cumulative:
			return load("res://characters/mobs/%s.tscn" % name)
	# fallback (shouldn't happen)
	return load("res://characters/mobs/virus_1A.tscn")


func spawn_mob():
	var mob_scene := get_weighted_mob(minutes)
	var new_mob := mob_scene.instantiate()
	%SpawnPath.progress_ratio = randf()
	new_mob.global_position = %SpawnPath.global_position
	add_child(new_mob)


func _on_spawn_increment_timeout() -> void:
	spawn_timer.wait_time = clamp(spawn_timer.wait_time - 0.5, 0.5, 1)

	if spawn_timer.wait_time <= 0.5 and extra_timers.size() < 3:
		var extra := Timer.new()
		extra.wait_time = 0.5
		extra.one_shot = false
		extra.timeout.connect(spawn_mob)
		add_child(extra)
		extra.start()
		extra_timers.append(extra)

func _on_spawn_timer_timeout() -> void:
	spawn_mob()

func convert_time_MMSS(time):
	minutes = time / 60
	var seconds = time % 60
	return "%02d:%02d" % [minutes, seconds]
	

func _on_elapsed_timer_timeout() -> void:
	elapsed_time += 1
	var formatted_time = convert_time_MMSS(elapsed_time)
	%ElapsedTime.set_text(formatted_time)
	
	
func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	%BackgroundMusic.pitch_scale = lerp(%BackgroundMusic.pitch_scale, 0.6, 0.1)
	Global.kill_player(%Player)
