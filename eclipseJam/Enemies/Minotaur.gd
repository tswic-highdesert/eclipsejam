extends CharacterBody2D

var targetLoc = Vector2.ZERO
var normalSpeed = 250
var aggroSpeed = 350
var chargeSpeed = 2000
var motion = Vector2.ZERO
var currentSpeed = normalSpeed
var inRange = false
var isCharging = false

@onready var stats = $EnemyStats



func _physics_process(delta):
	#print ("Current Speed: ", currentSpeed)
	
	if !isCharging:
		chase_player()
	else:
		charge_player()
		print ("Charging Initiated")



func chase_player():
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed
	move_and_slide()

func charge_player():
	isCharging = true
	currentSpeed = chargeSpeed
	
	velocity = (Global.player.global_position-global_position).normalized() * currentSpeed
	move_and_slide()

func flip():
	var direction = sign(Global.player.global_position.x - self.global_position.x)
	if direction < 0:
		$Sprite2D.set_flip_h(true)
	else:
		$Sprite2D.set_flip_h(false)


func _on_aggro_radius_body_entered(body):
	#We are not going to do anything with aggroradius for this enemytype
	pass


func _on_hurtbox_hit(damage):
	stats.health - damage


func _on_charge_cooldown_timeout():
	if currentSpeed == chargeSpeed:
		currentSpeed = 0
		$ChargeCooldown.start()
	elif currentSpeed == 0:
		currentSpeed = normalSpeed
	isCharging = false


func _on_charge_range_body_entered(body):
	if !isCharging:
		currentSpeed = 0
		$ChargeUp.start()

func _on_charge_up_timeout():
	charge_player()
