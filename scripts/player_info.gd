extends CanvasLayer


var elapsed_time = 0
var minutes = 0
	

func convert_time_MMSS(time):
	minutes = time / 60
	var seconds = time % 60
	return "%02d:%02d" % [minutes, seconds]
	

func _on_elapsed_timer_timeout() -> void:
	elapsed_time += 1
	var formatted_time = convert_time_MMSS(elapsed_time)
	%ElapsedTime.set_text(formatted_time)
