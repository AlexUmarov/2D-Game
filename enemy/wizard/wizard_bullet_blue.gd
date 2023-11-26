extends Node2D

@onready var anim = $AnimatedSprite2D
var speed = 50

@export var dirMove = 0

func _ready():
	anim.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if dirMove == "left":
		position += -transform.x * speed * delta
		$AnimatedSprite2D.flip_h = true
	else:
		position += transform.x * speed * delta


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.take_damage(20)
		queue_free()
