extends CharacterBody2D



#Health Code
@export var max_health : int = 100
@export var health : int = max_health

#Movement Speed
@export var normalSpeed = 500

var knockback = Vector2.ZERO
var currentSpeed = normalSpeed

@onready var animPlayer = $AnimationPlayer

func _physics_process(_delta):
	chase_player()
	anim_handler()
	
	#Resets Knockback on Impact
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
	if self.health <= 0:
		SignalManager.enemy_destroyed.emit(self)
		queue_free()

func chase_player():
	var direction = (Global.player.global_position - global_position).normalized()
	
	velocity = direction * currentSpeed + knockback
	
	move_and_slide()

func flip():
	var direction = sign(Global.player.global_position.x - self.global_position.x)
	$Sprite2D.set_flip_h(direction < 0)

func anim_handler():
	flip()
	if velocity.length() > 0:
		animPlayer.play("walking")
	else:
		animPlayer.play("idle")


func _on_hurtbox_area_entered(hitbox):
	var base_damage = hitbox.damage
	self.health -= base_damage
	
	var direction = hitbox.global_position.direction_to(global_position)
	var impulse = direction * hitbox.knockbackForce
	knockback = impulse
	
	Global.instance_scene_on_main(Global.HIT, global_position)
	
