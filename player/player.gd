extends CharacterBody2D

enum {
	MOVE,
	ATTACK,
	ATTACK2,
	ATTACK3,
	BLOCK,
	SLIDE,
	DAMADGE,
	DEATH
}

const SPEED = 50.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer
var health = 100
var gold = 0
var state = MOVE
var isAlive = true
var isDead = false
var run_speed = 1

func _physics_process(delta):
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()
		ATTACK2:
			pass
		ATTACK3:
			pass
		BLOCK:
			block_state()
		SLIDE:
			pass
		DAMADGE:
			take_damage_state()
		DEATH:
			death_state()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animPlayer.play("jump")

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if velocity.y >0:
		animPlayer.play("fall")

		#queue_free()
		#get_tree().change_scene_to_file("res://menu.tscn")
	

	move_and_slide()

func move_state():
	var direction = Input.get_axis("left", "right")
	if direction && isAlive:
		velocity.x = direction * SPEED * run_speed
		if velocity.y == 0:
			if run_speed == 1:
				animPlayer.play("walk")
			else:
				animPlayer.play("run")
	elif isAlive:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 && isAlive:
			animPlayer.play("idle")
	if direction == -1 && isAlive:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1 && isAlive:
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_pressed("run"):
		run_speed = 2
	else:
		run_speed = 1
	if Input.is_action_pressed("block"):
		state = BLOCK
		print("pressed block")
	if Input.is_action_pressed("attack"):
		state = ATTACK
	
func block_state ():
	velocity.x = 0
	animPlayer.play("block")
	if Input.is_action_just_released("block"):
		state = MOVE
		print("released block")
	
func attack_state() :
	velocity.x = 0
	animPlayer.play("attack")
	await animPlayer.animation_finished
	state = MOVE
		
	
	
func take_damage(damage=0) :
	if health >= damage:		
		if isAlive && state == BLOCK:
			if health > 20:
				health -= (20 - damage)
			else:
				health = 0
		else:
			if health > 40:
				health -= damage
			else:
				health = 0
		if health <= 0:
			isAlive = false
			state = DEATH
		else:
			state = DAMADGE
	else:
		print(damage)
		health = 0
		isAlive = false
		animPlayer.play("damage")
		await animPlayer.animation_finished
		state = DEATH
		
func take_damage_state():
	animPlayer.play("damage")
	await animPlayer.animation_finished
	state = MOVE
	
func death_state():
	if health <= 0 && !isAlive && !isDead:
		health = 0
		animPlayer.play("death")
		await animPlayer.animation_finished
		isDead = true
		
