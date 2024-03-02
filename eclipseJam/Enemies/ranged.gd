extends "res://Enemies/ParentEnemy.gd"



func _on_firing_range_body_entered(body):
	currentSpeed = 0


func _on_firing_range_body_exited(body):
	currentSpeed = aggroSpeed
