extends Node

var tile_size = 16

func spirit_tile_into_visual(v: Vector2) -> Vector2:
		return Vector2(v.y * tile_size, v.x * tile_size)
		
func visual_tile_into_spirit(v: Vector2) -> Vector2:
		return Vector2(v.y / tile_size, v.x / tile_size) #floor or ceil?
