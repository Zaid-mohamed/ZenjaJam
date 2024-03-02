extends Node2D

class_name global


@onready var AnimScene = preload("res://Global/Trans.tscn")

var Anim : AnimationPlayer
func _ready():
	Anim = AnimScene.instantiate()
	add_child(Anim)
func Close(NextScene : String):
	Anim.play("Close")
	await Anim.animation_finished
	get_tree().change_scene_to_file(NextScene)
func Open():
	Anim.play("OpenUp")

func change_scene(Scene : String):
	Anim.play("Close")
	await get_tree().create_timer(Anim.get_current_animation_length()).timeout
	get_tree().change_scene_to_file(Scene)
	Anim.play("OpenUp")
