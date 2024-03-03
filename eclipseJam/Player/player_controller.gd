extends CharacterBody2D

const DUST = preload("res://Effects/dust.tscn")
const projectile = preload("res://Projectiles/ParentBullet.tscn")

var playerStats = Global.PlayerStats
var canFire = true
var currentWeapon = clamp(1,1,5)


@export var speed = 1
@export var friction = 0.02
@onready var anim_player = $AnimationPlayer
@onready var sprite = $Player
@onready var weapon1 = $Player/WeaponArm
@onready var weapon2 = $RayCast2D

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

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Hi Mark")
			if currentWeapon == 2:
				fire_bullet()
				
	elif InputEventKey:
		# Check for mouse wheel movement
		if event.is_action_pressed("slot_one"):
			switch_weapon(1)
			print(currentWeapon)
		elif event.is_action_pressed("slot_two"):
			switch_weapon(2)
			print(currentWeapon)
	
func switch_weapon(newWeapon):
	if newWeapon == 1:
		weapon1.visible = true
		weapon2.visible = false
		currentWeapon = 1
	elif newWeapon == 2:
		weapon1.visible = false
		weapon2.visible = true
		currentWeapon = 2
	pass

func melee_attack():
	
	pass

func fire_bullet():
	if (canFire == true):
		var bullet = Global.instance_scene_on_main(projectile, $RayCast2D/FireLocation.global_position)
		bullet.direction = (get_local_mouse_position())
		$Timer.start()
	canFire = false
	pass


func _on_timer_timeout():
	canFire = true
	pass
