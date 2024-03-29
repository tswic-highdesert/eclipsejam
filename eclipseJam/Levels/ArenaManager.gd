extends Node2D


#Enemy Types
# Ghost - Melee (easiest)
# Harpee - Ranged
# Cyclops - Melee
# Minotaur - AOE
# Medusa - Ranged (hardest)

const PARENT = preload("res://Enemies/ParentEnemy.tscn")
#const CYCLOPS = preload("res://Enemies/cyclops.tscn")
#const GHOST = preload("res://Enemies/ghost.tscn")
#const HARPEE = preload("res://Enemies/harpee.tscn")
#const MEDUSA = preload("res://Enemies/medusa.tscn")
#const MINOTAUR = preload("res://Enemies/minotaur.tscn")

const INVICIBILITY_PICKUP = preload("res://Pickups/invincibility.tscn")
const HEALTH_PICKUP = preload("res://Pickups/healthpickup.tscn")


@onready var spawnArea1 = $"Spawn Area 1"
@onready var spawnArea2 = $"Spawn Area 2"
@onready var pickupArea = $"Pickup Area"
@onready var waveText = $CanvasLayer/Label
@onready var pause_menu = $Camera2D/PauseMenu

var WaveOne = {"enemies": [PARENT], "maxEnemies": 1}
var WaveTwo = {"enemies": [PARENT], "maxEnemies": 2}
var WaveThree = {"enemies": [PARENT], "maxEnemies": 3}
var WaveFour = {"enemies": [PARENT], "maxEnemies": 4}
var WaveFive = {"enemies": [PARENT], "maxEnemies": 66}

var pickups = [HEALTH_PICKUP]
var paused = false

var currentWave = {}
var enemyLineUp = []
var enemiesSpawnedCount = 0  # Counter for enemies spawned in the current wave
var enemiesAlive = []

func _ready():
	setWave(WaveOne)
	SignalManager.enemy_destroyed.connect(_on_enemy_destroyed)
	
	Music.play_song("gameplayLoop")

func setWave(wave):
	currentWave = wave
	enemyLineUp = currentWave["enemies"]
	enemiesSpawnedCount = 0  # Resets the counter when setting a new wave
	enemiesAlive = []

func spawn_enemies():
	var selectedSpawnArea = chooseSpawnArea()
	
	var center = selectedSpawnArea.position
	var size = selectedSpawnArea.get_node("CollisionShape2D").shape.extents
	var positionInArea = Vector2() # Initialize positionInArea

	positionInArea.x = randf() * size.x - (size.x / 2) + center.x
	positionInArea.y = randf() * size.y - (size.y / 2) + center.y
	
	if enemyLineUp.size() > 0 and enemiesSpawnedCount < currentWave["maxEnemies"]:
		enemyLineUp.shuffle()
		var enemyThatSpawns = enemyLineUp[0]
		var spawnedEnemy = Global.instance_scene_on_main(enemyThatSpawns, positionInArea)
		enemiesAlive.append(spawnedEnemy)  # Add spawned enemy to the list
		enemiesSpawnedCount += 1  # Increment the counter


func spawn_pickup():
	var center = pickupArea.position
	var size = pickupArea.get_node("CollisionShape2D").shape.extents
	var positionInArea = Vector2() # Initialize positionInArea

	positionInArea.x = randf() * size.x - (size.x / 2) + center.x
	positionInArea.y = randf() * size.y - (size.y / 2) + center.y
	pickups.shuffle()
	var pickupThatSpawns = pickups[0]
	Global.instance_scene_on_main(pickupThatSpawns, positionInArea)
	

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()




func chooseSpawnArea():
	var randomIndex = randi() % 2  # Assuming you have 2 spawn areas
	return [spawnArea1, spawnArea2][randomIndex]

func _on_enemy_destroyed(enemy):
	# Remove the destroyed enemy from the enemiesAlive list
	if enemiesAlive.has(enemy):
		enemiesAlive.erase(enemy)
	checkWaveStatus()

func _on_enemy_spawn_timer_timeout():
	spawn_enemies()

func checkWaveStatus():
	if enemiesAlive.size() == 0:
		$waveCooldown.start()
		SoundFX.play("church_bell")

func _on_wave_cooldown_timeout():
	startNextWave()
	SoundFX.stop()
	
func startNextWave():
	if currentWave == WaveOne:
		setWave(WaveTwo)
		waveText.text = "Wave 2"
		Music.play_song("gameplayLoop2")
		return
	if currentWave == WaveTwo:
		setWave(WaveThree)
		waveText.text = "Wave 3"
		Music.play_song("gameplayLoop3")
		return
	if currentWave == WaveThree:
		setWave(WaveFour)
		waveText.text = "Wave 4"
		Music.play_song("gameplayLoop4")
		return
	if currentWave == WaveFour:
		setWave(WaveFive)
		waveText.text = "Wave 5"
		Music.play_song("gameplayLoopfin")
		return
	else:
		print ("Waves Completed!")

func pauseMenu():
	if paused:
		$Camera2D/PauseVignette.hide()
		pause_menu.hide()
		get_tree().paused = false
	else:
		get_tree().paused = true
		pause_menu.show()
		$Camera2D/PauseVignette.show()
	paused = !paused



func _on_pickup_spawner_timeout():
	pass
