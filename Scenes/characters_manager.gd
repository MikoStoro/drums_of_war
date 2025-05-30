extends Node
class_name Character_Manager
static var character_packed_scene = preload("res://Scenes/character.tscn")
static var character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character=get_child(0)
	pass # Replace with function body.

static func add_character(c):
	character=character_packed_scene.instantiate()
	#add_child(character_packed_scene)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
