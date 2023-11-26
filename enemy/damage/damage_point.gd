extends Node2D

@export var incomeDamage = 0
@onready var timer = $Timer

func show_damage(damage):
	print("income damage ", damage)
	if damage >= 0:
		$Label.text = str(damage)
		$AnimationPlayer.play("throw")
		$AnimationPlayer.animation_finished
		timer.start(2)


func _on_timer_timeout():
	queue_free()
