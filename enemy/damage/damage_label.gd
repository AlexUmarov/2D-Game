extends Node2D

@export var incomeDamage = 0
@onready var timer = $Timer

func _ready():
	$Label.visible = false

func show_damage(attack: Attack):
	if attack.attack_damage >= 0:
		$Label.visible = true
		$Label.text = str(attack.attack_damage)
		$AnimationPlayer.play("throw")
		$AnimationPlayer.animation_finished
		timer.start(2)


func _on_timer_timeout():
	queue_free()
