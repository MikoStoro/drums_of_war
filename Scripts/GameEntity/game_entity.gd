extends Node2D
class_name VisualEntity
# BORN ANEW

@export var entity_data: GameEntityData
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = entity_data.sprite

func _recieve_hit(dmg : int) -> void:
	print("WAAAAGH")
	sprite.modulate = Color(1,1,1) #doesnt work on black...
	#hpbar.value -= dmg

func _move(coords: Vector2) -> void:
	var new_position = coords
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.05) 
	
func place(x: int,y: int):
	var coordinates = VisualBoardTools.spirit_tile_into_visual(Vector2(x,y))
	self.position.x = coordinates.x
	self.position.y = coordinates.y

# probably some game entity manager, dispatching orders to 
# entity, attack, indicator, hpbar
# this entity manager emits signal, for example taken damage
# entity and hpbar is interested

# draw lines (attack) should be another scene
# maybe one to play different resources (attacks) will be enough
	
# rotating direction indicator should be another script and scene
# probably as a child of character for realtive position

# and hp bar
