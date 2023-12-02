extends CharacterBody2D

@export var stateMachine: StateMachine
@export var animPlayer: AnimationPlayer
@export var anim: AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var wizardBullet = preload("res://enemy/wizard/wizard_bullet_blue.tscn")
@onready var bulletPointRight =  $BulletPointRight
@onready var bulletPointLeft =  $BulletPointLeft
"""
enum {
	IDLE,
	MOVE,
	ATTACK,
	WAIT,
}
"""
#var chase = false
#var attack = false
#var speed = 40
var alive = true
#var state = IDLE
var powerStrikeReady = true
@onready var powerStrikeTimer = $Timer
#var damageLabel = preload("res://enemy/damage/damage_label.tscn")
@export var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	"""
	var direction = (player.position - self.position).normalized()
	match state:
		IDLE:
			idle_state()
		MOVE:
			move_state(direction)
		ATTACK:
			attack_state()
		WAIT:
			wait_state()
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	move_and_slide()"""

func _physics_process(delta):
	if alive == true && stateMachine && animPlayer:
		if stateMachine.current_state.name.to_lower() == "attack" && powerStrikeReady == true:
			powerStrikeReady = false
			powerStrikeTimer.start(3)
			powerAttack()
			animPlayer.play("powerAttack")
			await animPlayer.animation_finished
		if stateMachine.current_state.name.to_lower() == "follow":
			animPlayer.play("run")
		if stateMachine.current_state.name.to_lower() == "idle":
			animPlayer.play("run")
		if velocity.x < 0:
			anim.flip_h = true
		elif velocity.x > 0:
			anim.flip_h = false
	move_and_slide()

func powerAttack():
	var tmpWizardBullet = wizardBullet.instantiate()
	if $AnimatedSprite2D.flip_h == true:
		tmpWizardBullet.position = bulletPointLeft.position
		tmpWizardBullet.dirMove = "left"
	else:
		tmpWizardBullet.position = bulletPointRight.position
		tmpWizardBullet.dirMove = "right"
	add_child(tmpWizardBullet)
	

"""
func idle_state():
	if alive == true:
		velocity.x = 0
		animPlayer.play("idle")
		
		


	
#func move_state(direction):
#	if chase == true:
#		velocity.x = direction.x * speed
#		animPlayer.play("run")

func attack_state():
	if attack == true && powerStrikeReady == true:
		velocity.x = 0
		animPlayer.play("powerAttack")
		await animPlayer.animation_finished
		powerStrikeReady = false
		powerStrikeTimer.start(1)
	else:
		state = WAIT

func wait_state():
	if powerStrikeReady == true:
		state = ATTACK
	else:
		state = IDLE

func _on_chase_detector_body_entered(body):
	if body.name == "Player":
		chase = true
		state = MOVE


func _on_chase_detector_body_exited(body):
	if body.name == "Player": 
		chase = false
		state = IDLE


func _on_attack_detector_body_entered(body):
	if body.name == "Player": 
		chase = true
		attack = true
		var tmpWizardBullet = wizardBullet.instantiate()
		if $AnimatedSprite2D.flip_h == true:
			tmpWizardBullet.position = bulletPointLeft.position
			tmpWizardBullet.dirMove = "left"
		else:
			tmpWizardBullet.position = bulletPointRight.position
			tmpWizardBullet.dirMove = "right"
		add_child(tmpWizardBullet)
		state = ATTACK


func _on_attack_detector_body_exited(body):
	if body.name == "Player": 
		chase == true
		attack = false
		state = MOVE
"""

func _on_timer_timeout():
	powerStrikeTimer.stop()
	powerStrikeReady = true

"""
func take_damage(attack: Attack) :
	pass
	#if alive == true && attack.attack_damage > 0:
		#var tmpDamageLabel = damageLabel.instantiate()
		#tmpDamageLabel.position = position
		#add_child(tmpDamageLabel)
		#tmpDamageLabel.show_damage(attack)
		#if hp > attack.attack_damage:
		#	hp -= attack.attack_damage
		#else:
		#	death()

func death():
	queue_free()
"""
