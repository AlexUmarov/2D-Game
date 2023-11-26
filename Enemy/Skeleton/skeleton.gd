
extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var speed = 100
@onready var anim = $AnimatedSprite2D
var alive = true
var hp = 100

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var player = $"../../Player/Player"
	var direction = (player.position - self.position).normalized()
	
	if alive == true:
		if chase == true:
			velocity.x = direction.x * speed
			anim.play("run")
		else:
			velocity.x = 0
			anim.play("idel")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	
	move_and_slide()
	
func take_damage(damage=0):
	if hp > damage:	
		hp -= damage
	else:
		death()
		
func _on_detector_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_detector_body_exited(body):
	if body.name == "Player": 
		chase = false

#func _on_death_body_entered(body):
	#if body.name == "Player":
		#death()
	
func death():	
	alive = false
	anim.play("death")
	await anim.animation_finished
	queue_free()

func _on_damage_body_entered(body):	
	if body.name == "Player":
		if alive:
			body.take_damage(0)
			#death()
			
			
