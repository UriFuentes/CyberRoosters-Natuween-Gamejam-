extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is not CharacterBody2D:
		return
	
	var xp_in_range = %CollectionRange.get_overlapping_areas()
	if xp_in_range.size():
		for xp in xp_in_range:
			if xp is xpPoint:
				xp.is_collected = true
	queue_free()
