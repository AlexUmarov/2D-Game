extends State
class_name Jump

@export var air_state : State
@export var ground_state : State

func state_process(delta):
	if (character.velocity.y > 0):
		animation_tree["parameters/conditions/is_fall_end"] = false
		next_state = air_state
	elif (character.is_on_floor()):
		#animation_tree["parameters/conditions/is_fall_end"] = true
		next_state = air_state

func on_exit():
	if (next_state == air_state && character.velocity.y > 0):
		playback.travel("fall")
	elif (character.is_on_floor()):
		character.has_double_jumped = false
		
func state_input(event : InputEvent):
	if (event.is_action_pressed("jump") && !character.has_double_jumped && character.can_double_jump):
		jump()
		
func jump():
	character.velocity.y = character.jump_velocity
	next_state = air_state
	playback.travel("jump")
