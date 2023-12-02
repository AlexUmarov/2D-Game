
extends CharacterBody2D

@export var player: CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var speed = 100
@onready var anim = $AnimatedSprite2D
var damageLable = preload("res://enemy/damage/damage_label.tscn")
var alive = true
var hp = 100

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
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
	


func _on_detector_body_entered(body):
	if body.name == "Player":
		chase = true
	


func _on_detector_body_exited(body):
	if body.name == "Player": 
		chase = false


func _on_death_body_entered(body):
	if body.name == "Player":
		death()
	
func death():
	alive = false
	anim.play("death")
	await anim.animation_finished
	queue_free()


func _on_damage_body_entered(body):	
	if body.name == "Player":
		if alive:
			var attack = Attack.new()
			attack.attack_damage = 20
			body.take_damage(attack)
			#death()
			

func take_damage(attack: Attack) :
	if alive == true && attack.attack_damage > 0:
		var tmpDamageLable = damageLable.instantiate()
		tmpDamageLable.position = position
		add_child(tmpDamageLable)
		tmpDamageLable.show_damage(attack)
		if hp > attack.attack_damage:
			hp -= attack.attack_damage
		else:
			death()
		
