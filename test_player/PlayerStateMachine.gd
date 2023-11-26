extends Node
class_name PlayerStateMachine

@export var states : Array[State]
@export var current_state : State

func _ready():
	for child in get_children():
		if (child is State):
			states.append(child)

func check_if_can_move():
	return current_state.can_move

func _process(delta):
	pass
