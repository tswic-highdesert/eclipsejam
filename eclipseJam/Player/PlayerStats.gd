extends Resource
class_name PlayerStats

signal health_updated(new_value)

var health: int = 100:
	set(new_value):
		health = clamp(new_value, 0, 100)
		emit_signal('health_updated', health)
