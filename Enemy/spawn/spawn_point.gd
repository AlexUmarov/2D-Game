extends Node2D

#var player = preload("res://player/player.tscn")
var enemy = preload("res://Enemy/Skeleton/skeleton.tscn")
@export var player: Node2D
#@export var enemy: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if player != null && enemy != null:
		var enemyTemp = enemy.instantiate()
		enemyTemp.position =  Vector2(0, 0)
		enemyTemp.player = player
		print(enemyTemp.position)
		add_child(enemyTemp)
