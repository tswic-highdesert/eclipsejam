extends "res://Enemies/ParentEnemy.gd"

const projectile = preload("res://Projectiles/ParentBullet.tscn")

var canFire = true
var inRange = false


func _physics_process(delta):
	chase_player(delta)
	if inRange == true:
		fire_projectile()
	flip()
	

func chase_player(delta):
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed
	move_and_slide()
	
	#rotation = (Global.player.global_position-global_position).normalized().angle()

func _on_firing_range_body_entered(body):
	currentSpeed = 0
	inRange = true
	#canFire = true

func _on_firing_range_body_exited(body):
	currentSpeed = aggroSpeed
	inRange = false
	canFire = false

func check_fire_status():
	if inRange == true:
		canFire = true
	elif inRange == false:
		canFire = false

func fire_projectile():
	if canFire == true && inRange == true:
		var bullet = Global.instance_scene_on_main(projectile, self.position)
		bullet.direction = (Global.player.global_position - self.global_position).normalized()
		canFire = false
		$Timer.start()
	else:
		pass


func _on_timer_timeout():
	check_fire_status()
	
