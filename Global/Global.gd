extends AnimationPlayer

class_name global





func _ready():
	add_to_group("global")
	add_child(self)
func Open():
	play("OpenUp")

func Close():

	play("Close")
	
