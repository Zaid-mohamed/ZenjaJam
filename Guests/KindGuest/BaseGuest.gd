extends CharacterBody2D

class_name BaseGuest
# Getting the Crystal Node
@onready var Crystal : StaticBody2D = get_tree().get_first_node_in_group("Crystal")
@export_group("Children")
@export var HitBox : Area2D
@export var StaringTimer : Timer
@export_group("Movement")
@export var Speed : float

var state : states = states.GoingToCrystal
enum states {
	GoingToCrystal,
	StaringAtCrystal,
	LeavingThePlace
}
enum types {
	Kind,
	Evil,
	Impostor,
	KindToEvil,
	EvilToKind,
	EvilToKindToEvil
}

func _ready():
	print(HitBox)
	HitBox.area_entered.connect(_area_enetered)
	StaringTimer.timeout.connect(leave)
func _physics_process(delta):
	# if the state is GoingToCrystal , then go to the crystal
	match state:
		states.GoingToCrystal:
			
			go_to_crystal() 
		states.StaringAtCrystal:
			Stare()
		states.LeavingThePlace:
			leave_the_place(Vector2(100, 100))
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
func leave_the_place(LeavingPoint):
	# getting the direction to the crystal (Vector2)
	var direction : Vector2 = LeavingPoint - global_position
	# Normalize it  and multiply it with Speed
	direction = direction.normalized() * Speed

	# Assign it to the velocity
	
	velocity = direction
	
func leave():
	# set the state to leaving the place to let leave_the_place func tion take place
	state = states.LeavingThePlace
func _area_enetered(area):
	# if it too close to the crystal it will stand and look at it
	if area.is_in_group("SafeArea"):
		state = states.StaringAtCrystal
		StaringTimer.start()
