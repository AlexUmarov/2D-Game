extends Node2D

func show_damage(damage):
	print("income damage ", damage)
	if damage >= 0:
		$".".visible = true
		$Label.text = str(damage)
		$AnimationPlayer.play("throw")
		$AnimationPlayer.animation_finished
		$".".visible = false
