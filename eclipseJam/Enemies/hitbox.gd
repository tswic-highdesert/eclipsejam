extends Area2D

@export var damage : int = 10
@export var knockbackIntensity : int = 4

#func _on_area_entered(hurtbox):
	#hurtbox.emit_signal("hit", damage)
	#print ("HIT")
