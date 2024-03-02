extends AnimationPlayer

class_name global





func _ready():
	add_child(self)
	add_to_group("global")
func Open():
	play("OpenUp")

func Close():

	play("Close")
	
