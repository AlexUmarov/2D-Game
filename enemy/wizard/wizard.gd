extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var chase = false
var attack = false
var speed = 40
@onready var animTree: AnimationTree = $AnimationTree
var alive = true
var hp = 100
var powerStrikeReady = true
@onready var powerStrikeTimer = $Timer

func update_anim_params():
	if velocity == Vector2.ZERO:
		animTree["parameters/conditions/idle"] = true
		animTree["parameters/conditions/is_run"] = false
	else:
		animTree["parameters/conditions/idle"] = false
		animTree["parameters/conditions/is_run"] = true
	if powerStrikeReady == true:
		animTree["parameters/conditions/powerAttack"] = true
	else:
		animTree["parameters/conditions/powerAttack"] = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animTree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_anim_params()
	if not is_on_floor():
		velocity.y += gravity * delta
	var player = $"../../Player/Player"
	var direction = (player.position - self.position).normalized()
	if alive == true:
		"""
		if chase == true:
			velocity.x = direction.x * speed
			animTree.play("run")
		else:
			velocity.x = 0
			animTree.play("idle")
			"""
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		"""
		if attack == true && powerStrikeReady == true:
			velocity.x = 0
			animTree.play("powerAttack")
			animTree.animation_finished
			#powerStrikeReady = false
			#powerStrikeTimer.start(5)
		else:
			velocity.x = 0
			animTree.play("idle")
		"""
	
	move_and_slide()


func _on_chase_detector_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_chase_detector_body_exited(body):
	if body.name == "Player": 
		chase = false


func _on_attack_detector_body_entered(body):
	if body.name == "Player": 
		attack = true


func _on_attack_detector_body_exited(body):
	if body.name == "Player": 
		attack = false


func _on_timer_timeout():
	powerStrikeTimer.stop()
	powerStrikeReady = true
