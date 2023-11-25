extends Node2D


<<<<<<< Updated upstream
var skeleton = preload("res://enemy/Skeleton/skeleton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
=======
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with functionw body.
>>>>>>> Stashed changes


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
<<<<<<< Updated upstream


func _on_timer_timeout():
	var skeletonTemp = skeleton.instantiate() 
	var rnd = randf_range(50, 50)
	skeletonTemp.position = Vector2(rnd, 550)
	add_child(skeletonTemp)
=======
>>>>>>> Stashed changes
