extends CharacterBody2D

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	

func _physics_process(delta):
	if is_multiplayer_authority():
		velocity = Input.get_vector("left","right","up","down") * 400
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position)
