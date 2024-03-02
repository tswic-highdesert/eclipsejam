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

var enemiesWave1 = [
	GHOST
]

var enemiesWave2 = [
	GHOST,
	HARPEE
]

var enemiesWave3 = [
	GHOST,
	HARPEE,
	CYCLOPS
]

var enemiesWave4 = [
	GHOST,
	HARPEE,
	CYCLOPS,
	MINOTAUR
]

var enemiesWave5 = [
	GHOST,
	HARPEE,
	CYCLOPS,
	MINOTAUR,
	MEDUSA
]


