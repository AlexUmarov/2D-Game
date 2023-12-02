extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
@export var move_speed := 0.0
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Pthysics_Update(delta: float):
	if player != null:
		if enemy.is_on_floor():
			var direction = Vector2(player.position.x - enemy.position.x, 0)
			if direction.length() > 30:
				Transitioned.emit(self, "Follow")
