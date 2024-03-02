extends Control


@onready var global :global = get_tree().get_first_node_in_group("global")

func _on_play_pressed():
	global.Close()
	await get_tree().create_timer(50)
	get_tree().change_scene_to_file("res://MainScene/main.tscn")


func _on_credits_pressed():
	global.Close()
	await get_tree().create_timer(0.5)
	
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_exit_pressed():
	get_tree().quit()
