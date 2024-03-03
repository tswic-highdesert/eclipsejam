extends Area2D

@export var damage = 1

@export var direction : Vector2 = Vector2.UP
@export var speed : float = 5.0
@onready var timer = $Timer

var endpoint = null
@onready var fireAOE = $CollisionShape2D/FireAOE


func _init():
	endpoint = get_local_mouse_position()

func _process(delta):
	position += (direction * speed) * delta
	detonation()
func _on_body_entered(body):
	pass # Replace with function body.

func detonation():
	if position == endpoint:
		fireAOE.enable
		$Timer.start()


func _on_timer_timeout():
	queue_free()

#extends RigidBody2D
#
#class_name MolotovProjectile
#
#@export var damage : int = 1
#@export var gravity : float = 500.0
#
#var initial_position : Vector2 = Vector2.ZERO
#var target_position : Vector2 = Vector2.ZERO
#var current_time : float = 0.0
#var total_time : float = 1.0
#
#func _ready():
	#initial_position = position
	#apply_central_impulse(Vector2.ZERO)  # Start with no initial impulse
#
#func _process(delta):
	#current_time += delta
	#if current_time > total_time:
		#queue_free()
	#else:
		#var t = current_time / total_time
		#var new_position = calculate_arc_position(t)
		#
		#var displacement = new_position - position
		#var gravity_force = Vector2(0, gravity) * mass  # Assuming 'mass' is the mass of the projectile
		#apply_central_impulse(displacement / delta + gravity_force) # Set linear velocity directly
#
#func calculate_arc_position(t: float) -> Vector2:
	## Use the provided target_position
	#if target_position == Vector2.ZERO:
	## Handle the case when target_position is not valid
		#return position
	#
	#var displacement: Vector2 = target_position - initial_position
	#var initial_velocity: Vector2 = (displacement - Vector2(0.5, 0.5) * gravity * total_time * total_time) / total_time
	#var current_velocity: Vector2 = initial_velocity + gravity * Vector2(t, t) * total_time
	#var current_position: Vector2 = initial_position + t * displacement + Vector2(0.5, 0.5) * t * t * gravity * total_time * total_time
	#return current_position
