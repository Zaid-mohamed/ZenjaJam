extends CharacterBody2D

class_name BaseGuest
# Getting the Crystal Node
@onready var crystal : Crystal = get_tree().get_first_node_in_group("Crystal")
@export_group("Children")
@onready var HitBox : Area2D = get_node("HitBox")
@onready var StaringTimer : Timer = get_node("StaringTimer")
@onready var Sprite : Sprite2D = get_node("Sprite2D")
@export_group("Movement")
@export var Speed : float = 500.0
var type : set = set_type
var state : states = states.GoingToCrystal : set = set_state
enum states {
	GoingToCrystal,
	StaringAtCrystal,
	LeavingThePlace
}
# types of all guests
enum types {
	Kind,
	Evil,
	Impostor,
	KindToEvil,
	EvilToKind,
	EvilToKindToEvil
}
# settters
func set_state(value):
	state = value
func set_type(value : types):
	type = value
func move_to(point : Vector2,  is_leaving : bool = false, speed = Speed):
	# the direction
	var direction : Vector2 = point - global_position
	# the distance between the guest and the headed point
	var distance_between_guest_and_point = sqrt(((point.x - global_position.x) * (point.x - global_position.x)) + ((point.y - global_position.y) * (point.y - global_position.y)))
	#Normalize 
	direction = direction.normalized() * speed
	
	velocity = direction
	if is_leaving  && distance_between_guest_and_point < 30:
		queue_free()
		
func handle_flip_h(Sprite : Sprite2D = Sprite):
	if velocity.x > 0.0:
		Sprite.flip_h = false
	elif velocity.x < 0.0:
		Sprite.flip_h = true
