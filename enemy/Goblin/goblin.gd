extends CharacterBody2D

@export var stateMachine: StateMachine
@export var animPlayer: AnimationPlayer
@export var anim: AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var attack_damage = 20

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
		
func _physics_process(delta):
	if stateMachine && animPlayer:
		if stateMachine.current_state.name.to_lower() == "attack":
			animPlayer.play("attack")
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




func _on_attack_area_left_area_entered(area):
	if area is HitboxComponent && anim.flip_h == true:
		print("left")
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.attack_position = global_position
		hitbox.damage(attack)


func _on_attack_area_right_area_entered(area):	
	if area is HitboxComponent && anim.flip_h != true:
		print("right")
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.attack_position = global_position
		hitbox.damage(attack)
