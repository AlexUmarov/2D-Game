extends Node
class_name StateMachineChar

@export var initial_state: StateChar
@export var stateLabel : Label
@export var animPlayer : AnimationPlayer
var current_state : StateChar
var stateDic: Dictionary = {}

func _ready():
	for child in get_children():
		if child is StateChar:
			stateDic[child.state_name] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)
		if animPlayer:
			animPlayer.play("idle")
		if stateLabel:
			if current_state.state_name == StateChar.IDLE:
				stateLabel.text = "IDLE"
			elif current_state.state_name == StateChar.WALK:
				stateLabel.text = "WALK"
			elif current_state.state_name == StateChar.RUN:
				stateLabel.text = "RUN"
			elif current_state.state_name == StateChar.ATTACK:
				stateLabel.text = "ATTACK"

func _physics_process(delta):
	if current_state:
		current_state.Pthysics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = stateDic.get(new_state_name)
	if !new_state:
		return
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state = new_state
