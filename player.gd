extends CharacterBody2D

@export var speed = 400






func _physics_process(delta):
	if Input.is_action_pressed("dow"):
		velocity.y =+ speed
	elif Input.is_action_pressed("up"):
		velocity.y =- speed
	else:
		velocity.y =0 
	
	if Input.is_action_pressed("rig"):
		velocity.x =+ speed
	elif Input.is_action_pressed("lef"):
		velocity.x =- speed
	else:
		velocity.x =0 
	
	
	
	move_and_slide()
	pass

