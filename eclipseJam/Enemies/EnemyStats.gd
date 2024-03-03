extends Node

@export var max_health = 3

var health = max_health

func set_health(value):
	health = clamp(value, 0, max_health)
	
	if health == 0:
		SignalManager.emit("enemy_destroyed")
