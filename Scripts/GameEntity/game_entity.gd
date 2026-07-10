extends Node2D
class_name GameEntity
# BORN ANEW

@export var entity_data: GameEntityData
@export var sprite: Sprite2D
var backend_id := -1

signal hit_recieved(amount: int)

func setup(id: int) -> void:
	sprite.texture = entity_data.sprite
	backend_id = id

func recieve_hit(dmg : int) -> void:
	hit_recieved.emit(dmg)
	
	#
#func _move(coords: Vector2) -> void:
	#var new_position = coords
	#var tween = create_tween()
	#tween.tween_property(self, "position", new_position, 0.05) 
	#
#func place(x: int,y: int):
	#var coordinates = VisualBoardTools.spirit_tile_into_visual(Vector2(x,y))
	#self.position.x = coordinates.x
	#self.position.y = coordinates.y
#
# it should dispatch events to 
#  attack, indicator, hpbar
# this entity manager emits signal, for example taken damage
# entity and hpbar is interested

# draw lines (attack) should be another scene
# maybe one to play different resources (attacks) will be enough
	
# rotating direction indicator should be another script and scene
# probably as a child of character for realtive position

# and hp bar
