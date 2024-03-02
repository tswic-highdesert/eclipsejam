extends "res://Enemies/ParentEnemy.gd"

const projectile = preload("res://Projectiles/ParentBullet.tscn")

var canFire = true
var inRange = false


func _physics_process(delta):
	chase_player(delta)
	if inRange == true:
		fire_projectile()
	
	print (currentSpeed)

func chase_player(delta):
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed
	move_and_slide()

func _on_firing_range_body_entered(body):
	currentSpeed = 0
	inRange = true

func _on_firing_range_body_exited(body):
	currentSpeed = aggroSpeed
	inRange = false

func fire_projectile():
	if canFire == true:
		Global.instance_scene_on_main(projectile, self.position)
		canFire = false
		$Timer.start()
	else:
		pass


func _on_timer_timeout():
	canFire = true
