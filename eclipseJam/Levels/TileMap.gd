extends TileMap

@onready var player = get_parent().get_child(1)

enum TerrainType {
	DIRT = 1,
	STONE = 2
}

signal terrain_change(type:int)

#terrain_change.emit(type)

func _physics_process(delta):
	print(check_terrain())
	


func check_terrain():
	var tile_data := get_cell_tile_data(0, Vector2i.ZERO)
	#var test_data = tile_data.get_custom_data("Terrain")
