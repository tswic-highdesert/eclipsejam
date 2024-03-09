extends CharacterBody2D

const DUST = preload("res://Effects/dust.tscn")
const BURST = preload("res://Effects/burst.tscn")
const projectile = preload("res://Projectiles/ParentBullet.tscn")
const molotov = preload("res://Projectiles/MolotovProjectile.tscn")

var canFire = true
var currentWeapon = 1

#Health Code
@export var max_health : int = 100
@export var health : int = max_health


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

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			fire_bullet()
			$armAnimationplayer.play("fire")

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
	$Player.set_flip_h(direction < 0)

func spawn_ground_effects():
	Global.instance_scene_on_main(DUST, $GroundMarker.global_position)
	SoundFX.play("grass_step")

func look_rotation():
	#Gets the mouse location and sets the muzzle rotation to match
	var look_vector = get_global_mouse_position() - global_position
	var angle = atan2(look_vector.y, look_vector.x)
	$Player/arm.rotation = angle

func fire_bullet():
	if (canFire == true):
		var bullet = Global.instance_scene_on_main(projectile, $Player/arm/FireLocation.global_position)
		bullet.direction = (get_local_mouse_position())
		bullet.rotation = $Player/arm.global_rotation
		$Timer.start()
		
		Global.instance_scene_on_main(BURST, $Player/arm/arm.global_position)
		
	canFire = false

func _on_timer_timeout():
	canFire = true

func _on_hurtbox_area_entered(hitbox):
	var base_damage = hitbox.damage
	self.health -= base_damage
	print ("Player's Health: ", self.health)
	
	#knockback code
	var attackDirection =  (self.global_position - hitbox.global_position).normalized()
	var knockback = attackDirection * speed
	velocity += knockback * hitbox.knockbackIntensity
