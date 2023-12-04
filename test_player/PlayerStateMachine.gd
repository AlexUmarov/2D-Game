extends Node
class_name PlayerStateMachine

@export var states : Array[State]
@export var current_state : State
@export var character : Test_player
@export var animation_tree : AnimationTree

func _ready():
	for child in get_children():
		if (child is State):
			states.append(child)
			child.animation_tree = animation_tree
			child.character = character 
			child.playback = animation_tree["parameters/playback"]
			
func _physics_process(delta):
	if (current_state.next_state != null):
		switch_states(current_state.next_state)
		
	current_state.state_process(delta)

func check_if_can_move():
	return current_state.can_move

func _process(delta):
	pass

func switch_states(new_state : State):
	if (current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		
	current_state = new_state
	current_state.on_enter()
	
func _input(event : InputEvent):
	current_state.state_input(event)
