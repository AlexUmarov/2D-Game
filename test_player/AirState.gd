extends State
class_name AirState

@export var landing_state : State
@export var ground_state : State
@export var jump_state : State
var max_velocity : float = 500
var velocity : float = 0

func state_process(delta):
	if (character.velocity.y > 0):
		velocity = character.velocity.y
	if (character.is_on_floor() && velocity > max_velocity):
		next_state = landing_state
	elif (character.is_on_floor()):
		next_state = ground_state
 
func on_exit():
	if (next_state == landing_state && velocity > max_velocity):
		character.has_double_jumped = false
		playback.travel("jump_end")
	elif (next_state == ground_state):
		character.has_double_jumped = false
		animation_tree["parameters/conditions/is_fall_end"] = true
	elif (next_state == jump_state):
		character.has_double_jumped = true
	velocity = 0
	
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump") && !character.has_double_jumped && character.can_double_jump):
		double_jump()

func double_jump():
	character.velocity.y = character.double_jump_velocity
	playback.travel("jump_start")
	character.has_double_jumped = true
	next_state = jump_state
