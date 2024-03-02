extends Node

class_name global

var anim



func _ready():
	anim = get_node("/root/Global/AnimationPlayer")
	add_to_group("global")
func Open():
	anim.play("OpenUp")
	await anim.animation_finished
func Close():

	anim.play("Close")
	await anim.animation_finished
	
