extends Node2D

var player


func _ready():
	get_player_character()
	var player_ins = player.instantiate()
	add_child(player_ins)
	player_ins.position = $MarkerPlayerPosition.position

func get_player_character():
	match Global.player_character:
		"pride":
			player = load("res://PrideChar/pride_char.tscn")
		"tim":
			player = load("res://test_player/test_player.tscn")
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
