extends Node
class_name VisualBoardTools

static var  tile_size: float = 16

static func spirit_tile_into_visual(v: Vector2) -> Vector2:
	return Vector2(v.y * tile_size + tile_size/2, v.x * tile_size + tile_size/2)
		
static func visual_tile_into_spirit(v: Vector2) -> Vector2:
	return ceil(Vector2(v.y / tile_size, v.x / tile_size)) #floor or ceil? 
