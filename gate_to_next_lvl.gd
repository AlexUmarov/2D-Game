extends Node2D

@export var next_level: int

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if next_level == 2:
			get_tree().change_scene_to_file("res://level_02/level_02.tscn")
		if next_level == 3:
			get_tree().change_scene_to_file("res://level_03/level_03.tscn")
