extends Node
class_name StateMachine

@export var initial_state: State
var current_state : State
var stateDic: Dictionary = {}

@export var stateLabel : Label 

func _ready():
	for child in get_children():
		if child is State:
			stateDic[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)
		if stateLabel:
			if current_state.name.to_lower() == "follow":
				stateLabel.text = str(current_state.name) +  " Arrrr!!!! "
			elif current_state.name.to_lower() == "idle":
				stateLabel.text = str(current_state.name) +  " Zzzzz! "
			else:
				stateLabel.text = str(current_state.name) +  " Aaaaa! "

func _physics_process(delta):
	if current_state:
		current_state.Pthysics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = stateDic.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state = new_state
