extends Area2D

@export var direction : Vector2 = Vector2.UP
@export var speed : float = 2
@onready var decayTimer = $decayTimer

func _process(delta):
	position += (direction * speed) * delta

func _on_timer_timeout():
	queue_free()


func _on_hitbox_area_entered(hurtbox):
	
	#This hides everything and makes it look like the projectile despawns. But that doesnt happen until the timer goes out
	$Hitbox.collision_layer = 0
	$Hitbox.collision_mask = 0
	
	$Sprite2D.visible = false
	$GPUParticles2D.emitting = false
	
	
	#Don't Queue Free, because then particles shut down
	#queue_free()
