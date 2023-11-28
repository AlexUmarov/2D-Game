extends State
class_name AirState

@export var landing_state : State
@export var double_jump_velocity : float = -250.0
var has_double_jumped : bool = false

func _ready():
	pass # Replace with function body.

func state_process(delta):
	if (character.is_on_floor()):
		next_state = landing_state

func on_exit():
	if (next_state == landing_state):
		playback.travel("jump_end")
		has_double_jumped = false
		
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump") && !has_double_jumped):
		double_jump()

func double_jump():
	character.velocity.y = double_jump_velocity
	playback.travel("double_jump")
	has_double_jumped = true

func _process(delta):
	pass
