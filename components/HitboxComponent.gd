extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var damage_label: Node2D

func damage(attack: Attack):
	print(attack)
	if health_component:
		health_component.damage(attack)
		if damage_label != null:
			damage_label.show_damage(attack)
