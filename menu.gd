extends Control





func _on_Play_pressed():
	
	get_tree().change_scene("res://MainScene/main.tscn")


func _on_credits_pressed():
	
	
	
	get_tree().change_scene_to_file("res://control.tscn")


func _on_exit_pressed():
	get_tree().quit()
