extends CharacterBody2D

var motion = Vector2.ZERO

@export var normalSpeed = 1
@export var aggroSpeed = 15

#@onready var aggroRadius = $aggroRadius.transform

var currentSpeed = normalSpeed


func _physics_process(delta):
	
	chase_player(delta)

func chase_player(delta):
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed
	move_and_slide()


func _on_aggro_radius_body_entered(body):
	print("Made it!")
	currentSpeed = aggroSpeed
