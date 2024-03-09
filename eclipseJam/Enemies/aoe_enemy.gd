extends "res://Enemies/ParentEnemy.gd"
var inRange = false
var canFire = false

func _physics_process(delta):
	chase_player(delta)
	#if inRange == true:
		
	 
func chase_player(delta):
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed
	move_and_slide()
	
	rotation = (Global.player.global_position-global_position).normalized().angle()
	
func _on_firing_range_body_entered(body):
	currentSpeed = 0
	inRange = true
	
func _on_firing_range_body_exited(body):
	currentSpeed = aggroSpeed
	inRange = false
	canFire = false
	
func check_fire_status():
	if inRange == true:
		canFire = true
	elif inRange == false:
		canFire = false
		
		




func _on_timer_timeout():
	check_fire_status()
