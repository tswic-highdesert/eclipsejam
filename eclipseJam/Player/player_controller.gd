extends CharacterBody2D

const DUST = preload("res://Effects/dust.tscn")
const projectile = preload("res://Projectiles/ParentBullet.tscn")
const molotov = preload("res://Projectiles/MolotovProjectile.tscn")

var playerStats = Global.PlayerStats
var canFire = true
var currentWeapon = 1


@export var speed = 1
@export var friction = 0.02
@onready var anim_player = $AnimationPlayer
@onready var sprite = $Player
@onready var weapon1 = $Player/Unarmed
@onready var weapon2 = $Player/Gun
@onready var weapon3 = $Player/Staff

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
		anim_player.play("walk")
	else:
		anim_player.play("idle")

func flip():
	var direction = sign(get_global_mouse_position().x - $Player.global_position.x)
	if direction < 0:
		$Player.set_flip_h(true)
		$Player/Unarmed.set_flip_v(true)
		$Player/Gun.set_flip_v(true)
		$Player/Staff.set_flip_v(true)
		
	else:
		$Player.set_flip_h(false)
		$Player/Unarmed.set_flip_v(false)
		$Player/Gun.set_flip_v(false)
		$Player/Staff.set_flip_v(false)
		
		
func spawn_ground_effects():
	Global.instance_scene_on_main(DUST, $GroundMarker.global_position)
	SoundFX.play("grass_step")

func look_rotation():
	#Gets the mouse location and sets the muzzle rotation to match
	var look_vector = get_global_mouse_position() - global_position
	weapon1.global_rotation = atan2(look_vector.y, look_vector.x)
	weapon2.global_rotation = atan2(look_vector.y, look_vector.x)
	weapon3.global_rotation = atan2(look_vector.y, look_vector.x)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if currentWeapon == 1:
				melee_attack_unarmed()
			elif currentWeapon == 2:
				fire_bullet()
			elif currentWeapon == 3:
				melee_attack_staff()
				
	elif InputEventKey:
		if event.is_action_pressed("slot_one"):
			switch_weapon(1)
			print(currentWeapon)
		elif event.is_action_pressed("slot_two"):
			switch_weapon(2)
			print(currentWeapon)
		elif event.is_action_pressed("slot_three"):
			switch_weapon(3)
			print(currentWeapon)
		#elif event.is_action_pressed("throw_molotov"):
			#throw_molotov()
			#print("throw!")
		
func switch_weapon(newWeapon):
	if newWeapon == 1:
		weapon1.visible = true
		$Player/Unarmed/UnarmedCollision.disabled = true
		weapon2.visible = false
		weapon3.visible = false
		currentWeapon = 1
	elif newWeapon == 2:
		weapon1.visible = false
		$Player/Unarmed/UnarmedCollision.disabled = false
		weapon2.visible = true
		weapon3.visible = false
		$Player/Staff/StaffCollision.disabled = true
		currentWeapon = 2
	elif newWeapon == 3:
		weapon1.visible = false
		$Player/Unarmed/UnarmedCollision.disabled = false
		weapon2.visible = false
		weapon3.visible = true
		currentWeapon = 3
	pass

func melee_attack_unarmed():
	if weapon1.visible == true: 
		$Player/Unarmed/UnarmedCollision.disabled = false
		weapon1.scale = Vector2(0.8, 1.2)
		await get_tree().create_timer(0.1).timeout  # Delay 1: 0.1 seconds
		weapon1.scale = Vector2(1.2, 0.8)  # Second scale
		await get_tree().create_timer(.2).timeout  # Delay for 0.3 seconds
		weapon1.scale = Vector2(1.0, 1.0)
		await get_tree().create_timer(0.3).timeout  # Delay 2: 0.2 seconds
		weapon1.scale = Vector2(0.9, 1.1)  # Reset scale after the delay
		$Player/Unarmed/UnarmedCollision.disabled = true
	else:
		pass

func melee_attack_staff():
	if weapon3.visible == true:
		var direction = sign(get_global_mouse_position().x - $Player.global_position.x)
		$Player/Staff/StaffCollision.disabled = false
		var initialRotation = null
		var targetRotation = null
		if direction < 0:
			initialRotation = weapon3.rotation +20
			targetRotation = initialRotation -2
		else:
			initialRotation = weapon3.rotation -20
			targetRotation = initialRotation + 2
		var duration = .5
		var elapsed = 0.0
		while elapsed < duration:
			weapon3.rotation = lerp(initialRotation, targetRotation, elapsed / duration)
			await get_tree().process_frame
			elapsed += get_process_delta_time()
		$Player/Staff/StaffCollision.disabled = true
	else:
		pass

func fire_bullet():
	if (canFire == true):
		var bullet = Global.instance_scene_on_main(projectile, $RayCast2D/FireLocation.global_position)
		bullet.direction = (get_local_mouse_position())
		$Timer.start()
	canFire = false
	pass

#func throw_molotov():
	#if playerStats.molotovCount > 0:
		#var newMolotov = Global.instance_scene_on_main(molotov, $RayCast2D/FireLocation.global_position)
		#var targetLoc = (get_local_mouse_position())
		#newMolotov.direction = (get_local_mouse_position())
		#if newMolotov.position == targetLoc:
			#pass
			#molotov.CollisionShape2D/FireAOE
	

func _on_timer_timeout():
	canFire = true
	pass
