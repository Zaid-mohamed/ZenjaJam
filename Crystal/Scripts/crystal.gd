extends StaticBody2D

class_name Crystal

var hope_level : int = 70 : set = set_hope_level

@onready var Sprite = get_node("CrystalStand")
@onready var GuestSafeArea = get_node("GuestSafeArea")
@onready var Anim = get_node("AnimationPlayer")

func decrease_hope_level(amount : int):
	hope_level -= amount
	return hope_level
func increase_hope_level(amount : int):
	hope_level += amount
	return hope_level

func set_hope_level(value : int):
	hope_level = value
	hope_level  = clamp(hope_level, 0, 100)
