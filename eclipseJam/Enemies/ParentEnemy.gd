extends CharacterBody2D


@export var normalSpeed = 35
@export var aggroSpeed = 55

#@onready var aggroRadius = $aggroRadius.transform

var motion = Vector2.ZERO
var currentSpeed = normalSpeed

signal enemy_destroyed

func _physics_process(delta):
	chase_player(delta)

func chase_player(delta):
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed
	move_and_slide()
	
func flip():
	var direction = sign(Global.player.global_position.x - self.global_position.x)
	if direction < 0:
		$Sprite2D.set_flip_h(true)
	else:
		$Sprite2D.set_flip_h(false)

func _on_aggro_radius_body_entered(body):
	currentSpeed = aggroSpeed

func _on_enemy_destroyed():
	emit_signal("enemy_destroyed")
	queue_free()  # Destroy the enemy instance
