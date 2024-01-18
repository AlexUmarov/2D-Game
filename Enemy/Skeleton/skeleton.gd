
extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var chase = false
var speed = 100
@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer

var alive = true
var hp = 100
var player: CharacterBody2D
var attack_damage = 10
#func _ready():
	#player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction
	var chaseDist
	if player:
		chaseDist = posmod(player.position.x, self.position.x)
		direction = (player.position - self.position).normalized()
	
	if alive == true:
		print(chaseDist)
		if chase == true && (377 > chaseDist || chaseDist > 30):
			velocity.x = (direction.x * speed)
			animPlayer.play("run")
		else:
			velocity.x = 0
			animPlayer.play("idle")
		if direction && direction.x < 0:
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
	if body.is_in_group("Player"):
		player = body
		chase = true

func _on_detector_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		chase = false

#func _on_death_body_entered(body):
	#if body.name == "Player":
		#death()
	
func death():
	alive = false
	animPlayer.play("death")
	await animPlayer.animation_finished
	queue_free()


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
