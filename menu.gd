extends Control


@onready var Global  = get_node("/root/Global")

@onready var timer = $Timer


func _on_play_pressed():
	
	Global.change_scene("res://MainScene/main.tscn")
	timer.start()
	await timer.timeout
	get_tree().change_scene_to_file("res://MainScene/main.tscn")
	


func _on_credits_pressed():
	
	

	

	get_tree().change_scene_to_file("res://control.tscn")


func _on_exit_pressed():
	get_tree().quit()
