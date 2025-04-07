extends Node
var tile_map: TileMapLayer
var size_x :int
var size_y :int
func _ready() -> void:
	tile_map = find_child("TileMapLayer")
	var rect = tile_map.get_used_rect()
	size_y = abs(rect.position.y - rect.end.y)
	size_x = abs(rect.position.x - rect.end.x)
	_map_into_array()
	
func _map_into_array() -> Array:
	var board: Array
	for y in size_y:
		board.append([])
		for x in size_x:
			var id = str(tile_map.get_cell_atlas_coords(Vector2i(x,y)))
			print(id)
			board[y].append(id)
		print()
			
	return board
