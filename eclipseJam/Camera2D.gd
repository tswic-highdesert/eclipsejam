extends Camera2D

@onready var timer = $Timer

func _ready():
	SignalManager.add_screenshake.connect(_on_add_screenshake)

func _on_add_screenshake():
	pass
