extends CharacterBody2D


@export var normalSpeed = 250
@export var aggroSpeed = 350

var motion = Vector2.ZERO
var currentSpeed = normalSpeed


func _physics_process(delta):
	chase_player()

func chase_player():
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
	#SignalManager.enemy_destroyed.emit(self)
	#queue_free()

