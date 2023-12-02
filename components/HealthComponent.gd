extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10
var health : float
var is_death : bool

func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	if !is_death:
		health -= attack.attack_damage
		if health <= 0:
			is_death = true
