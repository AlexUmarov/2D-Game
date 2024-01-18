extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -250.0

#@export var stateMachine: StateMachineChar

@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer
@onready var animTree: AnimationTree = $AnimationTree
@onready var foot_step = $Audio/FootStepASP
@onready var attack_audio = $Audio/AttackAudio


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isAlive = true
var run_speed = 1
var canWalk = true
var attack_damage = 20

func _ready():
	animTree.active = true

func _process(delta):
	update_anim_params()

func update_anim_params():
	if velocity.x == 0:
		animTree["parameters/conditions/idle"] = true
		animTree["parameters/conditions/jump"] = false
		animTree["parameters/conditions/run"] = false
		animTree["parameters/conditions/walk"] = false
	else:
		animTree["parameters/conditions/walk"] = true
		animTree["parameters/conditions/idle"] = false
		animTree["parameters/conditions/jump"] = false
		animTree["parameters/conditions/run"] = false
		animTree["parameters/conditions/attack"] = false
		if Input.is_action_pressed("run"):
			animTree["parameters/conditions/run"] = true
			animTree["parameters/conditions/idle"] = false
			animTree["parameters/conditions/jump"] = false
			animTree["parameters/conditions/walk"] = false
			animTree["parameters/conditions/attack"] = false
		else:
			animTree["parameters/conditions/walk"] = true
			animTree["parameters/conditions/idle"] = false
			animTree["parameters/conditions/jump"] = false
			animTree["parameters/conditions/run"] = false
			animTree["parameters/conditions/attack"] = false
		
	if Input.is_action_pressed("attack"):
		animTree["parameters/conditions/attack"] = true
	else:
		animTree["parameters/conditions/attack"] = false
		
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animTree["parameters/conditions/jump"] = true
	else: 
		animTree["parameters/conditions/jump"] = false
		
	#if Input.is_action_pressed("block"):
	#if Input.is_action_pressed("run"):
	



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = Input.get_axis("left", "right")
	
	if direction !=0 && isAlive && canWalk && Input.is_action_pressed("run"):
		run_speed = 2
		if $TimerStep.time_left <=0.1 && is_on_floor():
			foot_step.pitch_scale = randf_range(0.8, 1.2)
			foot_step.play()
			$TimerStep.start(0.25)
	else:
		run_speed = 1
	if direction !=0 && isAlive && canWalk:
		velocity.x = direction * SPEED * run_speed
		if $TimerStep.time_left <=0.1 && is_on_floor():
			foot_step.pitch_scale = randf_range(0.8, 1.2)
			foot_step.play()
			$TimerStep.start(0.35)
	else:
		velocity.x = 0

	if direction == -1 && isAlive:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1 && isAlive:
		$AnimatedSprite2D.flip_h = false
	move_and_slide()


func attack_start():
	attack_audio.pitch_scale = randf_range(0.8, 1.2)
	attack_audio.play()
	canWalk = false
	print("attack start")
	
func attack_finish():
	canWalk = true
	print("attack finish")


func _on_right_attack_area_area_entered(area):
	if area is HitboxComponent && anim.flip_h != true:
		print("right")
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.attack_position = global_position
		hitbox.damage(attack)



func _on_left_attack_area_area_entered(area):
	if area is HitboxComponent && anim.flip_h == true:
		print("left")
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.attack_position = global_position
		hitbox.damage(attack)
