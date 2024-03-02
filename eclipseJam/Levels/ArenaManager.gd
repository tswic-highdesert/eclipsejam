extends Node2D


#Enemy Types
# Ghost - Melee (easiest)
# Harpee - Ranged
# Cyclops - Melee
# Minotaur - AOE
# Medusa - Ranged (hardest)

const CYCLOPS = preload("res://Enemies/cyclops.tscn")
const GHOST = preload("res://Enemies/ghost.tscn")
const HARPEE = preload("res://Enemies/harpee.tscn")
const MEDUSA = preload("res://Enemies/medusa.tscn")
const MINOTAUR = preload("res://Enemies/minotaur.tscn")


@onready var spawnArea1 = $"Spawn Area 1"
@onready var spawnArea2 = $"Spawn Area 2"

var WaveOne = [
	GHOST
]

var WaveTwo = [
	GHOST,
	HARPEE
]

var WaveThree = [
	GHOST,
	HARPEE,
	CYCLOPS
]

var WaveFour = [
	GHOST,
	HARPEE,
	CYCLOPS,
	MINOTAUR
]

var WaveFive = [
	GHOST,
	HARPEE,
	CYCLOPS,
	MINOTAUR,
	MEDUSA
]

var enemyLineUp = [
	
]

func _ready():
	createEnemyLineUp(WaveTwo)

func createEnemyLineUp(wave):
	enemyLineUp = []
	enemyLineUp = wave

func spawn_enemies():
	var selectedSpawnArea = chooseSpawnArea()
	
	var center = selectedSpawnArea.position
	var size = selectedSpawnArea.get_node("CollisionShape2D").shape.extents
	var positionInArea = Vector2() # Initialize positionInArea

	positionInArea.x = randf() * size.x - (size.x / 2) + center.x
	positionInArea.y = randf() * size.y - (size.y / 2) + center.y
	
	enemyLineUp.shuffle()
	var enemyThatSpawns = enemyLineUp[0]
	
	Global.instance_scene_on_main(enemyThatSpawns, positionInArea)

func chooseSpawnArea():
	var randomIndex = randi() % 2  # Assuming you have 2 spawn areas
	return [spawnArea1, spawnArea2][randomIndex]

func _on_timer_timeout():
	spawn_enemies()
