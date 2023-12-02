extends Node2D

@onready var anim = $AnimatedSprite2D
var speed = 50

@export var dirMove = 0
@export var attack_damage:= 20
var curBodyName

func _ready():
	anim.play("move")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if dirMove == "left":
		position += -transform.x * speed * delta
		$AnimatedSprite2D.flip_h = true
	else:
		position += transform.x * speed * delta


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		curBodyName = body.name
		#var attack = Attack.new()
		#attack.attack_damage = 20
		#body.take_damage(attack)
		#queue_free()


func _on_area_2d_area_entered(area):
	if area is HitboxComponent && curBodyName == "Player":
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.attack_position = global_position
		hitbox.damage(attack)
		queue_free()
