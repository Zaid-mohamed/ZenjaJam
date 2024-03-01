extends CharacterBody2D


@export var Speed : float = 200.0
@export var StaringTime : float 

@onready var crysalPos : Vector2 = get_tree().get_first_node_in_group("crystal").global_position
@onready var crystal : crystal = get_tree().get_first_node_in_group("crystal")

@onready var Exits  = get_tree().get_nodes_in_group("Exit")

@onready var NavAgent : NavigationAgent2D

@onready var HitBox : Area2D = get_node("HitBox")

@onready var StaringTimer : Timer = get_node("StaringTimer")

@onready var NavTimer : Timer = get_node("NavTimer")
var state : states = states.GoingToCrystal : set = set_state

var is_stared : bool

var NavTarget : Node2D

var exit : Vector2
enum states {
	GoingToCrystal,
	Staring,
	Leaving
}


func _ready():
	# settings up the navigation
	NavAgent = $NavAgent
	NavAgent.path_desired_distance = 4.0
	NavAgent.target_desired_distance = 4.0
	NavTarget = crystal
	actor_setup()
	#get an exit
	exit = get_an_exit()
	# assign stare time to the wait time of staring timer
	StaringTimer.wait_time = StaringTime
	#connect the area entered
	HitBox.area_entered.connect(entered_an_area)
	# connect staring timer timeout
	StaringTimer.timeout.connect(staring_finished)
func _physics_process(delta):
	# match the state to functions
	match state:
		states.GoingToCrystal:
			move_to(crysalPos)
		states.Staring:
			staring()
		states.Leaving:
			move_to(exit, true)

	
	if NavAgent.is_navigation_finished():
		return
	var next_path_position: Vector2 = NavAgent.get_next_path_position()
	var new_velocity = next_path_position - global_position
	
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * Speed
	velocity = new_velocity
	

	move_and_slide()

#this is a Navigation purpose too
func move(Velocity):
	velocity = Velocity
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
	
	return Exits[random.randi_range(1, Exits.size() - 1)].global_position





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
			crystal.hope_level += 10
			StaringTimer.start()
			

# when staring timer finishes
func staring_finished():
	state = states.Leaving
	


# navigation purposses



func actor_setup():
	await get_tree().physics_frame

	set_movement_target(NavTarget.position)
	NavTimer.start()
func set_movement_target(target_position : Vector2):
	NavAgent.target_position = target_position
