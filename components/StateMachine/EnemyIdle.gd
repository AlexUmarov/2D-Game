extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0
var player: CharacterBody2D
var move_direction: Vector2
var wander_time: float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), 0).normalized()
	wander_time = randf_range(1, 2)

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func Pthysics_Update(delta: float):
	if enemy && player:
		if enemy.is_on_floor():
			enemy.velocity = move_direction * move_speed
		var direction = Vector2(player.position.x - enemy.position.x, 0)
		if direction.length() < 150:
			Transitioned.emit(self, "Follow")
