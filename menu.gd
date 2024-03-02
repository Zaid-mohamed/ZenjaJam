extends Control


@onready var global :global = get_tree().get_first_node_in_group("global")

func _on_play_pressed():
	global.Close()
	get_tree().change_scene_to_file("res://MainScene/main.tscn")


func _on_credits_pressed():
	global.Close()
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_exit_pressed():
	pass # Replace with function body.
