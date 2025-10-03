extends Node
class_name Character_Manager
static var character_packed_scene = preload("res://Scenes/character.tscn")
static var character:Character
static var characters = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character=get_child(0)
	pass # Replace with function body.

func add_character(x, y):
	var c : Character =character_packed_scene.instantiate() 
	
	characters.append(c)
	c.x_pos=x
	c.y_pos=y
	add_child(c)

func get_characters() -> Array[Character]:
	return characters.duplicate()
func get_players() -> Array[Character]:
	return get_characters().filter(func(c): return !c.is_ai)

	
