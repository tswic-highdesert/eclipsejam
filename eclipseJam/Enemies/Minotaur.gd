extends CharacterBody2D

var targetLoc = Vector2.ZERO
var normalSpeed = 250
var aggroSpeed = 350
var chargeSpeed = 2000
var motion = Vector2.ZERO
var currentSpeed = normalSpeed
var inRange = false
var isCharging = false
var stunned = false


#Health Code
@export var max_health : int = 100
@export var health : int = max_health


func _physics_process(delta):
	if !stunned:
		if !isCharging:
			chase_player()
			$AnimationPlayer.speed_scale = 1
		else:
			charge_player()
			$AnimationPlayer.speed_scale = 2
	
	anim_handler()
	
	if self.health <= 0:
		SignalManager.enemy_destroyed.emit(self)
		queue_free()
	move_and_slide()

func anim_handler():
	flip()
	if currentSpeed > 0:
		$AnimationPlayer.play("walking")
	elif currentSpeed == 0:
		$AnimationPlayer.play("idle")



func chase_player():
	currentSpeed = aggroSpeed
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed

func charge_player():
	isCharging = true
	currentSpeed = chargeSpeed
	
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed

func flip():
	var direction = sign(Global.player.global_position.x - self.global_position.x)
	if direction < 0:
		$Sprite2D.set_flip_h(true)
	else:
		$Sprite2D.set_flip_h(false)


func _on_aggro_radius_body_entered(body):
	#We are not going to do anything with aggroradius for this enemytype
	pass

func stop_charging():
	$ChargeCooldown.start()
	stunned = true

func _on_charge_cooldown_timeout():
	currentSpeed = normalSpeed
	isCharging = false
	stunned = false


func _on_charge_range_body_entered(body):
	if !isCharging:
		stunned = true
		$ChargeUp.start()

func _on_charge_up_timeout():
	charge_player()
	stunned = false

func _on_hitbox_area_entered(hurtbox):
	stop_charging()


func _on_hurtbox_area_entered(hitbox):
	if isCharging:
		stop_charging()
	else:
		stunned = true
	
	var base_damage = hitbox.damage
	self.health -= base_damage
	print ("Enemy's Health: ", self.health)
	
