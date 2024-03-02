extends Control




func _on_play_pressed():
	var Global  = get_node("/root/Global")
	
	Global.change_scene("res://menu.tscn")


func _on_credits_pressed():
	
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_exit_pressed():
	get_tree().quit()
