extends Node
class_name Character_Manager
static var character_packed_scene = preload("res://Scenes/character.tscn")
static var characters : Array[Character] = []
static var summons : Array[Summon] = []
static var character : Character ##TODO By the Omnissiah! Not very multiplayer-friendly

static var summon_lookup : Dictionary ={
	GlobalEnums.summon_type.basic_projectile : preload("res://Scenes/projectile.tscn")
}

static var npc_lookup : Dictionary = {
	GlobalEnums.npc_type.charger : preload("res://Scenes/ai_charger.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		characters.append(c)
	self.character = get_child(0) #need to look into that
	GlobalComponents.character_manager = self

func add_character(data: Dictionary):
	var character : Character = character_packed_scene.instantiate() 
	character.setup(data)
	character.controller.controls = data.get("InputMode")
	characters.append(character)
	add_child(character)
	
func add_npc(npc_type: GlobalEnums.npc_type, data:Dictionary):
	var character = npc_lookup[npc_type].instantiate()
	character.setup(data)
	characters.append(character)
	add_child(character)

func add_summon(summon_name:GlobalEnums.summon_type, data: Dictionary):
	var summon = summon_lookup[summon_name].instantiate()
	summon.setup(data)
	summons.append(summon)
	add_child(summon)

func get_characters() -> Array[Character]:
	return characters.duplicate()
func get_players() -> Array[Character]:
	return get_characters().filter(func(c): return !c.is_ai)

	
