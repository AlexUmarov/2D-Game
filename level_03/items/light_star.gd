extends Node2D

var move_direction: Vector2
var energy: float
var wander_time: float
var move_speed := 10.0
@onready var light = $PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	#light.energy = wander_time
	#position = move_direction * move_speed


func randomize_wander():
	move_direction = Vector2(randf_range(-.1, .1), 0).normalized()
	wander_time = randf_range(.3, .5)
	#energy = randf_range(.1, .3)
