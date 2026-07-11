extends Node
class_name CharacterManager

static var character_packed_scene = preload("res://Scenes/character.tscn")
static var characters : Array[AbstractCharacter] = []
static var summons : Array[Summon] = []

@export var board : AbstractBoard 

static var summon_lookup : Dictionary[GlobalEnums.summon_type,Summon] ={
	#GlobalEnums.summon_type.basic_projectile : 
}

static var npc_lookup : Dictionary[GlobalEnums.npc_type, AbstractCharacter] = {
	#GlobalEnums.npc_type.charger : preload("res://Scenes/ai_charger.tscn")
}

func _ready() -> void:
	BackendGlobalComponents.character_manager = self

func create_starting_state():
	pass ## here you can add characters that will be on the board at the start of the game

func add_character(data: CharacterSpawnData):
	var character : AbstractCharacter = AbstractCharacter.new()
	character.setup(data)
	characters.append(character)
	board.place_character(character, data.x, data.y)
	
func add_npc(npc_type: GlobalEnums.npc_type, data:Dictionary):
	var character = npc_lookup[npc_type]
	character.setup(data)
	characters.append(character)

func add_summon(summon_name:GlobalEnums.summon_type, data: Dictionary):
	var summon = summon_lookup[summon_name].instantiate()
	summon.setup(data)
	summons.append(summon)
	add_child(summon)

func get_character_by_id(character_id : int):
	for c : AbstractCharacter in self.characters:
		if c.id == character_id: return c
	return null

func get_characters() -> Array[AbstractCharacter]:
	return characters.duplicate()

func get_players() -> Array[AbstractCharacter]:
	return get_characters().filter(func(c): return !c.is_ai)
