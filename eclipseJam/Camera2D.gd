extends Camera2D

@onready var timer = $Timer

func _ready():	
	SignalManager.add_screenshake.connect(_on_add_screenshake)

func _on_add_screenshake(duration: float, amplitude : float):
	if duration > 0:
		var offset = Vector2(randf(), randf()).normalized() * amplitude
		
		offset.x += position.x
		offset.y += position.y
		position = offset
	else:
		position = Vector2()
