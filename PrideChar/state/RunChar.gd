extends StateChar
class_name RunChar

@export var move_speed := 40.0
@export var animPlayer: AnimationPlayer
var player: CharacterBody2D
var state_name = StateChar.RUN

func Enter():
	player = get_tree().get_first_node_in_group("PrideChar")

func Pthysics_Update(delta: float):
	if player != null:
		if player.is_on_floor() && animPlayer:
			var direction = Input.get_axis("left", "right")
			if direction !=0:
				player.velocity.x = direction * move_speed
				#animPlayer.play("run")
			else:
				player.velocity.x = 0
			if player.velocity.x == 0:
				Transitioned.emit(self, StateChar.IDLE)
