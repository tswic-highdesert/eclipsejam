extends "res://Pickups/PickupBase.gd"

@onready var playerStats = Global.PlayerStats
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_body_entered(body):
	playerStats.health = playerStats.health +1
	print(playerStats.health)
	queue_free() # Replace with function body.

