extends CharacterBody2D


class_name player

@export var CanMove : bool = true
# Speed Acceleration and friction
@export var Speed : float
@export var Acc : float
@export var Friction : float

#children nodes

@onready var Anim : AnimationPlayer = get_node("Anim")
@onready var Sprite : Sprite2D = get_node("Texture")
@onready var AttackArea : Area2D = get_node("AttackArea")

#
@onready var global : global = get_node("/root/Global")
func _ready():
	if global:
		global.Open()
func _physics_process(delta):
	if CanMove:
		movement()
	handle_animations()
	handle_flip_h()
	handle_attack()

func movement():
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if dir:
		velocity.x = move_toward(velocity.x, dir.x * Speed, Acc * get_physics_process_delta_time())
		velocity.y = move_toward(velocity.y, dir.y * Speed, Acc * get_physics_process_delta_time())
	else:
		velocity.x = move_toward(velocity.x, 0.0, Friction * get_physics_process_delta_time())
		velocity.y = move_toward(velocity.y, 0.0, Friction * get_physics_process_delta_time())
	move_and_slide()
func handle_animations():
	if velocity != Vector2.ZERO && CanMove:
		Anim.play("Run")
	elif velocity == Vector2.ZERO && CanMove:
		Anim.play("Idle")

# Handles what direction the player will look to.
func handle_flip_h():
	if velocity.x > 0.0:
		Sprite.flip_h = false
		AttackArea.rotation_degrees = 0.0
		
	elif velocity.x < 0.0:
		Sprite.flip_h = true
		AttackArea.rotation_degrees = 180.0
func handle_attack():
	if Input.is_action_just_pressed("Attack"):
		CanMove = false
		velocity = Vector2.ZERO
		Anim.play("Attack")
		await Anim.animation_finished
		CanMove = true
		
		
