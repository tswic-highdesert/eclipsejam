extends Area2D

@onready var playerStats = Global.PlayerStats

var invinHealth = 10000
var originalHealth = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	playerStats = Global.PlayerStats.health
	originalHealth = playerStats.health
	playerStats.health = invinHealth
	$Timer.start()
	$CollisionShape2D.disable
	$Sprite2D.invisible


func _on_timer_timeout():
	playerStats.health = originalHealth
	queue_free()
	pass # Replace with function body.
