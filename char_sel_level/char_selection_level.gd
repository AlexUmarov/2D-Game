extends Node2D


var selArea = preload("res://char_sel_level/selection_area.tscn")
var light = preload("res://level_03/items/light_star.tscn")
var current_character_selecterd

# Called when the node enters the scene tree for the first time.
func _ready():
	for char in $Characters.get_children():
		char.add_child(selArea.instantiate())
		var tmp_light = light.instantiate()
		#tmp_light.position = char.position
		tmp_light.visible = false
		char.add_child(tmp_light)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func character_selected(name):
	current_character_selecterd = name
	$Label.text = current_character_selecterd
	for char in $Characters.get_children():
		var l = char.get_node("LightStar")
		if char.name == name:
			l.visible = true
		else:
			l.visible = false
	


func _on_button_pressed():
	if current_character_selecterd:
		print("load scene ", current_character_selecterd)
		Global.set_player_character(current_character_selecterd)
		get_tree().change_scene_to_file("res://level_03/level_03.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
