extends BaseGuest


class_name KindGuest



func _ready():
	set_type(types.Kind)
	print(HitBox)
	HitBox.area_entered.connect(_area_enetered)
	StaringTimer.timeout.connect(leave)
func _physics_process(delta):
	handle_flip_h()
	# if the state is GoingToCrystal , then go to the crystal
	match state:
		states.GoingToCrystal:
			
			move_to(crystal.global_position)
		states.LeavingThePlace:
				move_to(Vector2(0, -1000), true)
		states.StaringAtCrystal:
			Stare()
	move_and_slide()


# when state = stare it will stand
func Stare():
	velocity = Vector2.ZERO
	
func leave():
	# set the state to leaving the place to let leave_the_place func tion take place
	state = states.LeavingThePlace
func _area_enetered(area):
	# if it too close to the crystal it will stand and look at it
	if area.is_in_group("SafeArea"):
		state = states.StaringAtCrystal
		crystal.increase_hope_level(10)
		StaringTimer.start()
