extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0

var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Pthysics_Update(delta: float):
	if player != null:
		if enemy.is_on_floor():
			var direction = Vector2(player.position.x - enemy.position.x, 0)
			if direction.length() > 30:
				enemy.velocity = direction.normalized() * move_speed
			else:
				Transitioned.emit(self, "Attack")
			if direction.length() > 200:
				Transitioned.emit(self, "Idle")

