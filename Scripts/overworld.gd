extends Node
var tile_map: TileMapLayer
var size_x :int
var size_y :int
func _ready() -> void:
	tile_map = find_child("TileMapLayer")
	var rect = tile_map.get_used_rect()
	size_y = abs(rect.position.y - rect.end.y)
	size_x = abs(rect.position.x - rect.end.x)
	print(_map_into_array())
	
func _map_into_array() -> Array:
	var board: Array
	for y in size_y:
		board.append([])
		for x in size_x:
			var field = Field.new()
	
			field.x = x
			field.y = y
			board[y].append(field)
		print()
			
	return board
