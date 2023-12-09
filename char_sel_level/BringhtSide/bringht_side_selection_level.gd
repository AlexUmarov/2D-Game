extends Node2D

var selArea = preload("res://char_sel_level/BringhtSide/bright_sel_area.tscn")
var current_character_selecterd

func _ready():
	for char in $Characters.get_children():
		char.add_child(selArea.instantiate())


func character_selected(name):
	current_character_selecterd = name
	$Label.text = current_character_selecterd
	#for char in $Characters.get_children():
	#	var l = char.get_node("LightStar")
	#	if char.name == name:
	#		l.visible = true
	#	else:
	#		l.visible = false


func _on_play_pressed():
	if current_character_selecterd:
		Global.set_player_character(current_character_selecterd)
		get_tree().change_scene_to_file("res://level_01/level_01.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
