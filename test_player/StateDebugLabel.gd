extends Label

@export var state_machine : PlayerStateMachine 
@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity : float = player.velocity.y
	var vel : String = str(int(velocity))
	text = "State: " + state_machine.current_state.name + "\nVelocity " + vel
