extends Area2D

@export var damage : int = 10
@export var knockbackForce : int = 1500

func _on_area_entered(hurtbox):
	hurtbox.emit_signal("hit", damage)
	print ("HIT")
