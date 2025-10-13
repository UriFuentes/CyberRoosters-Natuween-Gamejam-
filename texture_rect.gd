extends TextureRect

func _process(delta):
	var offset = -%Player.global_position
	position = offset
