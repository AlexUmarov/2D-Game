extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../../player/player" != null:
		text = "Power Strike on cooldown: " + str($"../../player/player".powerStrikeTimer.time_left)
