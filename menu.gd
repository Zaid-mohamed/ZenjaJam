extends Control

@onready var Global  = get_node("/root/Global")
@onready var timer = $Timer


func _on_play_pressed():
	Global.change_scene("res://MainScene/main.tscn")
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://MainScene/main.tscn")
	


func _on_credits_pressed():
	
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_exit_pressed():
	get_tree().quit()
