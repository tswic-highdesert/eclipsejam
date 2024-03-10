extends Area2D

@onready var playerStats = Global.PlayerStats

var invinHealth = 10000
var originalHealth = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(_body):
	originalHealth = playerStats.health
	playerStats.health = invinHealth
	print("Invincible!,", playerStats.health)
	$Timer.start()
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false


func _on_timer_timeout():
	playerStats.health = originalHealth
	print("Vincible!", playerStats.health)
	queue_free()
	pass # Replace with function body.
