extends Control

var boot_finished = false


func _ready() -> void:
	%BootAnimation.play("boot_sequence")
	

func _process(delta: float) -> void:
	if boot_finished and Input.is_anything_pressed():
		%BootSequence.visible = false
		%TitleScreen.set_modulate(Color(1,1,1,0)) # Set alpha to 0 to avoid flicker
		%TitleScreen.visible = true
		%BootAnimation.play("title_screen")


func _on_boot_animation_finished(anim_name: StringName) -> void:
	if anim_name == "boot_sequence":
		boot_finished = true
	
	if anim_name == "title_screen":
		get_tree().change_scene_to_file("res://cyberooster.tscn")
