extends Area2D

@onready var character = get_parent()
@onready var char_selection_level = get_tree().get_root().get_node("char_selection_level")
signal character_selected


func _ready():
	connect("character_selected",char_selection_level.character_selected)

func _on_input_event(viewport, event: InputEvent, shape_idx):
	if event.is_action_pressed("mouse_click_selection"):
		emit_signal("character_selected", character.name)
	
