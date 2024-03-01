extends Node2D



@export var max_wait_time : float
@export var min_wait_time : float

var KindGuestScene = preload("res://KindGuest/kind_guest.tscn")
var EvilGuestScene = preload("res://EvilGuest/evil_guest.tscn")





@onready var SpawnPoints = get_tree().get_nodes_in_group("SpawnPoint")

@onready var SpawnTimer : Timer = get_node("SpawnTimer")


func _ready():
	randomize()
	get_random_wait_time()
	SpawnTimer.timeout.connect(SpawnTimerTimeout)
	SpawnTimer.start()
func spawn_kind_guest(GuestScene):
	get_random_wait_time()
	var random = RandomNumberGenerator.new()
	
	var SpawnPoint = SpawnPoints[random.randi_range(1, SpawnPoints.size() - 1)].global_position
	
	var guest = GuestScene.instantiate()
	
	
	guest.global_position = SpawnPoint
	
	add_child(guest)



func get_random_wait_time():
	var random = RandomNumberGenerator.new()
	
	SpawnTimer.wait_time = random.randf_range(min_wait_time, max_wait_time)

func choose_scene():
	var random = RandomNumberGenerator.new()
	var chosen = random.randi_range(1, 2)
	match chosen:
		1:
			return EvilGuestScene
		2:
			return KindGuestScene
		_:
			pass
func SpawnTimerTimeout():
	spawn_kind_guest(choose_scene())
