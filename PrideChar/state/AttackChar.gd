extends StateChar
class_name AttackChar

@export var animPlayer: AnimationPlayer
var player: CharacterBody2D
var state_name = StateChar.ATTACK

func Enter():
	player = get_tree().get_first_node_in_group("PrideChar")


func Pthysics_Update(delta: float):
	if player != null:
		if player.is_on_floor() && animPlayer:
			if Input.is_action_pressed("attack"):
				animPlayer.play("attack")
			if player.velocity == Vector2.ZERO:
				Transitioned.emit(self, StateChar.IDLE)
