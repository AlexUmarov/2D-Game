extends State
class_name GroundState

@export var jump_state : State
@export var jump_animation : String = "jump_start"
@export var velocity_to_change_state : float = 150

func _ready():
	pass 


func state_process(delta):
	if (!character.is_on_floor() && abs(character.velocity.y) > velocity_to_change_state):
		next_state = jump_state

func state_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	
func jump():
	character.velocity.y = character.jump_velocity
	next_state = jump_state
	playback.travel(jump_animation)
