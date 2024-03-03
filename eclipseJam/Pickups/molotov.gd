extends Node2D

var PlayerStats = preload("res://Player/PlayerStats.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	PlayerStats.molotovCount = 5
	print(PlayerStats.molotovCount)
	queue_free() # Replace with function body.
