extends Area2D

@onready var anim = $AnimatedSprite2D
var speed = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	anim.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(target_body):
	target_body.take_damage(20)
