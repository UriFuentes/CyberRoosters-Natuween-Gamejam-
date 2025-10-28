extends Node2D



func kill_player(Node) -> void:
	Node.visible = false
	Node.PROCESS_MODE_DISABLED
