extends CharacterBody2D


class_name Guest

@onready var crysalPos : Vector2 = get_tree().get_first_node_in_group("crystal").global_position
@onready var crystal : crystal = get_tree().get_first_node_in_group("crystal")
@onready var Exits  = get_tree().get_nodes_in_group("Exit")
@onready var player : player = get_tree().get_first_node_in_group("player")

@export var Speed : float = 200.0
@export var StaringTime : float 
@export var KnockBackForce : float
@export var change_on_hope_level : float

@export var NavAgent : NavigationAgent2D

@export var HitBox : Area2D

@export var StaringTimer : Timer

@export var NavTimer : Timer

@export var Anim : AnimationPlayer

var state : states = states.GoingToCrystal : set = set_state

var is_stared : bool

var NavTarget : Node2D

var exit : Vector2

var Set_up : bool = false
enum states {
	GoingToCrystal,
	Staring,
	Leaving
}


func _ready():
	# settings up the navigation
	NavAgent = $NavAgent
	NavAgent.path_desired_distance = 4
	NavAgent.target_desired_distance = 4
	NavTarget = crystal
	#get an exit
	exit = get_an_exit()
func set_up():
	actor_setup()
	# assign stare time to the wait time of staring timer
	StaringTimer.wait_time = StaringTime
	#connect the area entered
	HitBox.area_entered.connect(entered_an_area)
	# connect staring timer timeout
	StaringTimer.timeout.connect(staring_finished)
	Set_up = true
func _physics_process(delta):
	if !Set_up:
		set_up()
	# match the state to functions
	match state:
		states.GoingToCrystal:
			move_to(crysalPos)
		states.Staring:
			staring()
		states.Leaving:
			move_to(exit, true)

	handle_animations()
	if NavAgent.is_navigation_finished():
		return
	var next_path_position: Vector2 = NavAgent.get_next_path_position()
	var new_velocity = next_path_position - global_position
	
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * Speed
	velocity = new_velocity

	move_and_slide()







# move to a point, it can be a normal point or an exit
func move_to(point: Vector2, is_leaving : bool = false):
	set_movement_target(point)
	
	if is_leaving:
		var DistanceFromExit = sqrt(pow(point.y - global_position.y, 2) + pow(point.x - global_position.x, 2))
		if DistanceFromExit < 10:
			queue_free()


# get an exit position
func get_an_exit() -> Vector2:
	var random = RandomNumberGenerator.new()
	
	return Exits[random.randi_range(1, Exits.size() - 1)].position





#    setters
func set_state(value : states):
	state = value
	if state == states.Staring:
		#stare
		
		is_stared = true

func staring():
	velocity = Vector2.ZERO
	
	
#   signals

# when enters an area
func entered_an_area(area):
	if area.is_in_group("safe_zone") && !is_stared:
		if !is_stared:
			
			state = states.Staring
			crystal.hope_level += change_on_hope_level
			StaringTimer.start()
	if area.is_in_group("AttackArea"):
		KnockBack()
		

# when staring timer finishes
func staring_finished():
	state = states.Leaving
	

func handle_animations():
	if Anim:
		
		if velocity == Vector2.ZERO:
			Anim.play("Idle")
		elif velocity != Vector2.ZERO:
			Anim.play("Run")

# navigation purposses



func actor_setup():
	await get_tree().physics_frame

	set_movement_target(NavTarget.position)
	NavTimer.start()
func set_movement_target(target_position : Vector2):
	NavAgent.target_position = target_position


func KnockBack():
	var KnockbackVector : Vector2 = global_position.direction_to(player.global_position)
	KnockbackVector = KnockbackVector * KnockBackForce
	velocity = KnockbackVector
	move_and_slide()
	state = states.Staring
