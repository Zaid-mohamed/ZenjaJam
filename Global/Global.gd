extends Node2D

class_name global


@onready var Anim : AnimationPlayer = get_node("/root/Global/Anim")


func _ready():
	add_child(Anim)
func Close(NextScene : String):
	Anim.play("Close")
	await Anim.animation_finished
	get_tree().change_scene_to_file(NextScene)
func Open():
	Anim.play("OpenUp")

func change_scene(Scene : String):
	Anim.play("Close")
	await Anim.animation_finished
	get_tree().change_scene_to_file(Scene)
	Anim.play("OpenUp")
