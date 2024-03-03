extends Control

@onready var Global  = get_node("/root/Global")



func _on_Play_pressed():
	
	get_tree().change_scene("res://MainScene/main.tscn")


func _on_credits_pressed():
	
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_exit_pressed():
	get_tree().quit()
