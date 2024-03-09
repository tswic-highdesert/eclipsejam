extends CharacterBody2D

var targetLoc = Vector2.ZERO
var normalSpeed = 250
var aggroSpeed = 350
var chargeSpeed = 2000
@onready var stats = $EnemyStats

var motion = Vector2.ZERO
var currentSpeed = normalSpeed
var inRange = false


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
	#SignalManager.enemy_destroyed.emit(self)
	#queue_free()

func _on_hurtbox_hit(damage):
	stats.health - damage
	
func charge_player():
	currentSpeed = chargeSpeed
	var playerRelativePos = Global.player.global_position - global_position
	var offset = playerRelativePos.normalized() * Vector2(500, 500)  # Adjust the offset as needed
	targetLoc = Global.player.global_position + offset
	velocity = (targetLoc - global_position).normalized() * chargeSpeed
	#if position == targetLoc:
		#currentSpeed = 0
		#pass
	
func _on_charge_range_body_entered(body):
	print(Global.player.global_position)
	print(position)
	inRange == true
	currentSpeed = 0
	$ChargeCooldown.start();
	$RunToTimer.start();
	$aggroRadius.monitoring = false
	$aggroRadius/CollisionShape2D.disabled = true
	$ChargeRange.monitoring = false
	$ChargeRange/ChargeTrigger.disabled = true
	
func _on_charge_cooldown_timeout():
	inRange = false
	$aggroRadius.monitoring = true
	$aggroRadius/CollisionShape2D.disabled = false
	$ChargeRange.monitoring = true
	$ChargeRange/ChargeTrigger.disabled = false
	currentSpeed = normalSpeed
	pass # Replace with function body.


func _on_run_to_timer_timeout():
	print(Global.player.global_position)
	charge_player()
	pass # Replace with function body.
