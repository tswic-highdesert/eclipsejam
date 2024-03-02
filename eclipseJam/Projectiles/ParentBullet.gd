extends Area2D

@export var damage = 1

@export var direction : Vector2 = Vector2.UP
@export var speed : float = 50.0

@onready var timer = $Timer

func _process(delta):
	position += (direction * speed) * delta

func _on_body_entered(body):
	pass # Replace with function body.

func _on_timer_timeout():
	queue_free()
