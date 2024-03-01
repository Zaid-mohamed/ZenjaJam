extends CharacterBody2D


@export var Speed : float = 200.0
@export var StaringTime : float 

@onready var crysalPos : Vector2 = get_tree().get_first_node_in_group("crystal").global_position
@onready var crystal : crystal = get_tree().get_first_node_in_group("crystal")

@onready var Exits  = get_tree().get_nodes_in_group("Exit")

@onready var HitBox : Area2D = get_node("HitBox")

@onready var StaringTimer : Timer = get_node("StaringTimer")

var state : states = states.GoingToCrystal : set = set_state

var is_stared : bool

var exit : Vector2
enum states {
	GoingToCrystal,
	Staring,
	Leaving
}


func _ready():
	$Type.text ="im kind"
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
	move_and_slide()







# move to a point, it can be a normal point or an exit
func move_to(point: Vector2, is_leaving : bool = false):
	var direction : Vector2 = point - global_position
	
	direction = direction.normalized() * Speed
	
	velocity = direction
	
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
	
