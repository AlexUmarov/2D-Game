extends Node2D

func _on_quit_pressed():
	get_tree().quit()

func _on_bright_side_button_pressed():
	get_tree().change_scene_to_file("res://char_sel_level/BringhtSide/bringht_side_selection_level.tscn")


func _on_dark_side_button_pressed():
	get_tree().change_scene_to_file("res://char_sel_level/char_selection_level.tscn")
