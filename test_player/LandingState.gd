extends State
class_name LandingState
@export var ground_sate : State


func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "jump_end"):
		next_state = ground_sate
