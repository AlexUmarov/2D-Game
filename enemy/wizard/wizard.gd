extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum {
	IDLE,
	MOVE,
	ATTACK,
	WAIT,
}

var wizardBullet = preload("res://enemy/wizard/wizard_bullet_blue.tscn")
@onready var bulletPointRight =  $BulletPointRight
@onready var bulletPointLeft =  $BulletPointLeft

var chase = false
var attack = false
var speed = 40
#@onready var animTree: AnimationTree = $AnimationTree
@onready var animPlayer: AnimationPlayer = $AnimationPlayer
var alive = true
var hp = 100
var state = IDLE
var powerStrikeReady = true
@onready var powerStrikeTimer = $Timer
var damagePoint = preload("res://enemy/damage/damage_point.tscn")

"""	
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
"""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#update_anim_params()
	if not is_on_floor():
		velocity.y += gravity * delta
	var player = $"../../Player/Player"
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
	move_and_slide()

func idle_state():
	if alive == true:
		velocity.x = 0
		animPlayer.play("idle")
		
		


	
func move_state(direction):
	if chase == true:
		velocity.x = direction.x * speed
		animPlayer.play("run")
		
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


func _on_timer_timeout():
	powerStrikeTimer.stop()
	powerStrikeReady = true

func take_damage(damage=0) :
	if alive == true && damage > 0:
		var tmpDamagePoint = damagePoint.instantiate()
		tmpDamagePoint.position = position
		add_child(tmpDamagePoint)
		tmpDamagePoint.show_damage(damage)
		if hp > damage:
			hp -= damage
		else:
			death()

func death():
	queue_free()
