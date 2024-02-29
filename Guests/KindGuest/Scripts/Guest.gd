extends CharacterBody2D

class_name Guest
# Getting the Crystal Node
@onready var Crystal : StaticBody2D = get_tree().get_first_node_in_group("Crystal")
@onready var HitBox : Area2D = get_node("HitBox")
@onready var StaringTimer : Timer = get_node("StaringTimer")
@export_group("Movement")
@export var Speed : float

var state : states = states.GoingToCrystal
enum states {
	GoingToCrystal,
	StaringAtCrystal,
	LeavingThePlace
}

func _ready():
	HitBox.area_entered.connect(_area_enetered)
	StaringTimer.timeout.connect(leave_the_place)
func _physics_process(delta):
	# if the state is GoingToCrystal , then go to the crystal
	match state:
		states.GoingToCrystal:
			
			go_to_crystal() 
		states.StaringAtCrystal:
			Stare()
	move_and_slide()
func go_to_crystal():
	# getting the direction to the crystal (Vector2)
	var direction : Vector2 = Crystal.global_position - global_position
	# Normalize it  and multiply it with Speed
	direction = direction.normalized() * Speed

	# Assign it to the velocity
	
	velocity = direction

# when state = stare it will stand
func Stare():
	velocity = Vector2.ZERO
func leave_the_place():
	var LeavingPoint : Vector2
func _area_enetered(area):
	# if it too close to the crystal it will stand and look at it
	if area.is_in_group("SafeArea"):
		state = states.StaringAtCrystal
		StaringTimer.start()
