extends StateChar
class_name IdleChar

@export var move_speed := 10.0
@export var animPlayer: AnimationPlayer
var player: CharacterBody2D
var move_direction: Vector2
var wander_time: float
var state_name = StateChar.IDLE

func Enter():
	player = get_tree().get_first_node_in_group("PrideChar")

func Pthysics_Update(delta: float):
	if player:
		if player.is_on_floor() && animPlayer:
			animPlayer.play("idle")
			if player.velocity.x != 0:
				Transitioned.emit(self, StateChar.RUN)
