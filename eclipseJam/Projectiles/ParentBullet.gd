extends Area2D

@export var damage = 1

@export var direction : Vector2 = Vector2.UP
@export var speed : float = 2
@onready var Player = preload("res://Player/player.tscn")
@onready var playerStats = Global.PlayerStats
@onready var timer = $Timer

func _process(delta):
	position += (direction * speed) * delta

func _on_body_entered(body):
	playerStats.health -= 1
	queue_free()


func _on_timer_timeout():
	queue_free()
