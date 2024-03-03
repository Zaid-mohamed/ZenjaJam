extends StaticBody2D

class_name crystal
var hope_level : int = 100 : set = set_hope_level
@onready var temp_hope_label : Label = get_node("UI/HopeLabel")

# setters

func set_hope_level(value : int):
	hope_level = clampi(value, 0, 200)
	temp_hope_label.text = "hope level : " + str(hope_level)
	print(hope_level)
