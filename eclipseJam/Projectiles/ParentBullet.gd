extends Area2D

@export var damage = 1

@export var direction : Vector2 = Vector2.UP
@export var speed : float = 2
@onready var Player = preload("res://Player/player.tscn")
@onready var playerStats = Global.PlayerStats
@onready var timer = $Timer

func _process(delta):
	position += (direction * speed) * delta

func _on_timer_timeout():
	pass#queue_free()


func _on_hitbox_area_entered(area):
	pass#queue_free()
