extends "res://Enemies/ParentEnemy.gd"

@onready var playerStats = Global.PlayerStats
@onready var Player = preload("res://Player/player.tscn") 
var attackCooldownActive = false
var playerInOverlap = false

func _process(delta):
	var overlapping_bodies = $PlayerAttack.get_overlapping_bodies()
	if overlapping_bodies and not attackCooldownActive and not playerInOverlap:
		for body in overlapping_bodies:
			if body is CharacterBody2D:
				_on_player_attack_body_entered(body)
				
			break

func _on_player_attack_body_entered(body):
	
	$PlayerAttack/CollisionShape2D.disabled = true
	$AttackCooldown.start()
	playerStats.health -= 1
	attackCooldownActive = true

func _on_attack_cooldown_timeout():
	$PlayerAttack/CollisionShape2D.disabled = false
	attackCooldownActive = false
