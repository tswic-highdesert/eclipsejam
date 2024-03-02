extends CharacterBody2D

const DUST = preload("res://Effects/dust.tscn")

var playerStats = Global.PlayerStats

@export var speed = 1
@export var friction = 0.02


@onready var anim_player = $AnimationPlayer
@onready var sprite = $Player

var scale_speed = 9
var mousePos = Vector2()

func _ready():
	Global.player = self

func _physics_process(delta):
	
	flip()
	calc_movement(delta)
	move_and_collide(velocity)
	calc_anims()


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

