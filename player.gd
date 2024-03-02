extends CharacterBody2D


class_name player
# Speed Acceleration and friction
@export var Speed : float
@export var Acc : float
@export var Friction : float


#children nodes

@onready var Anim : AnimationPlayer = get_node("Anim")
@onready var Sprite : Sprite2D = get_node("Texture")


func _physics_process(delta):
	movement()
	handle_animations()
	handle_flip_h()

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
	if velocity != Vector2.ZERO:
		Anim.play("Run")
	else:
		Anim.play("Idle")

# Handles what direction the player will look to.
func handle_flip_h():
	if velocity.x > 0.0:
		Sprite.flip_h = false
	elif velocity.x < 0.0:
		Sprite.flip_h = true
