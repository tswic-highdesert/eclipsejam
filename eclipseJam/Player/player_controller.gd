extends CharacterBody2D

const DUST = preload("res://Effects/dust.tscn")

var playerStats = Global.PlayerStats

@export var speed = 1
@export var friction = 0.02
@onready var anim_player = $AnimationPlayer
@onready var sprite = $Player


func _ready():
	Global.player = self

func _physics_process(delta):
	
	flip()
	calc_movement(delta)
	move_and_collide(velocity)
	calc_anims()
	look_rotation()


func calc_movement(delta):
	var direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
	direction = direction.normalized()
	
	
	velocity = velocity.lerp(direction * speed, 0.1)
	velocity *= 1.0 - (friction * delta)

func calc_anims():
	if velocity.length() > 0.05:
		anim_player.play("run")
	else:
		anim_player.play("idle")

func flip():
	var direction = sign(get_global_mouse_position().x - $Player.global_position.x)
	if direction < 0:
		$Player.set_flip_h(true)
	else:
		$Player.set_flip_h(false)

func spawn_ground_effects():
	Global.instance_scene_on_main(DUST, $GroundMarker.global_position)
	SoundFX.play("grass_step")

func look_rotation():
	#Gets the mouse location and sets the muzzle rotation to match
	var look_vector = get_global_mouse_position() - global_position
	$RayCast2D.global_rotation = atan2(look_vector.y, look_vector.x) - PI/2

func switch_weapon():
	pass

func melee_attack():
	pass

func fire_bullet():
	pass
