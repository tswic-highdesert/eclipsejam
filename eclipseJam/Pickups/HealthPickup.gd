extends "res://Pickups/PickupBase.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	var playerStats = Global.PlayerStats.health
	playerStats.health = playerStats.health + 1
	queue_free() # Replace with function body.

