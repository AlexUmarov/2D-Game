extends CanvasLayer

@export var health_component : HealthComponent
@export var player: CharacterBody2D
@onready var health = $HP
@onready var gold = $Gold
@onready var ps = $PS
	
# Called when the node enters the scene tree for the first time.
#func _ready():
#	player = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player && health_component:
		health.text = "HP: " + str(health_component.health)
		#gold.text = "coin: " + str(player.gold)
		#ps.text = "PS: " + str(player.powerStrikeTimer.time_left).substr(0,1)
