extends Node

var PlayerStats = preload("res://Player/PlayerStats.tres")

var player = null

signal add_screenshake(amount, duration)

#Singleton for instancing scenes within a scene. ex: playerBullet
func instance_scene_on_main(scene, position):
	var main = get_tree().current_scene
	var instance = scene.instantiate()
	main.add_child(instance)
	instance.global_position = position
	return instance
