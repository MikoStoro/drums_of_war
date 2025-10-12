extends Node
class_name Character_Manager
static var character_packed_scene = preload("res://Scenes/character.tscn")
static var character:Character
static var characters : Array[Character] = []
static var summons : Array[Summon] = []

static var summon_lookup : Dictionary ={
	GlobalEnums.summon_type.basic_projectile : preload("res://Scenes/projectile.tscn")
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		characters.append(c)
	character=get_child(0)
	GlobalComponents.character_manager = self

func add_character(x, y):
	var c : Character = character_packed_scene.instantiate() 
	characters.append(c)
	c.x_pos=x
	c.y_pos=y
	add_child(c)

func add_summon(summon_name:GlobalEnums.summon_type, data: Dictionary):
	var summon = summon_lookup[summon_name].instantiate()
	summon.setup(data)
	summons.append(summon)
	add_child(summon)

func get_characters() -> Array[Character]:
	return characters.duplicate()
func get_players() -> Array[Character]:
	return get_characters().filter(func(c): return !c.is_ai)

	
