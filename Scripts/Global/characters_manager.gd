extends Node
class_name CharacterManager

var character_packed_scene = preload("res://Scenes/character.tscn")
var characters : Array[AbstractCharacter] = []
var summons : Array[Summon] = []
var characters_to_remove : Array[AbstractCharacter] = [] # characters will be deleted at the end of the turn

@export var clock : BackendClock
@export var board : AbstractBoard 

static var summon_lookup : Dictionary[GlobalEnums.summon_type,Summon] ={
	#GlobalEnums.summon_type.basic_projectile : 
}

static var npc_lookup : Dictionary[GlobalEnums.npc_type, AbstractCharacter] = {
	#GlobalEnums.npc_type.charger : preload("res://Scenes/ai_charger.tscn")
}

func _ready() -> void:
	BackendGlobalComponents.character_manager = self
	clock.send_events.connect(commit_character_removal)

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
	summon.setup(data) ## TODO - shouldn't summons be trated as characters?
	summons.append(summon)

func commit_character_removal():
	for c : AbstractCharacter in characters_to_remove:
		characters.erase(c)
	characters_to_remove.clear()

func remove_character(character : AbstractCharacter):
	characters_to_remove.append(character)

func remove_character_by_id(character_id : int):
	var character_to_remove : AbstractCharacter = get_character_by_id(character_id)
	remove_character(character_to_remove)

func get_character_by_id(character_id : int):
	for c : AbstractCharacter in self.characters:
		if c.id == character_id: return c
	return null

func get_characters() -> Array[AbstractCharacter]:
	return characters.duplicate()

func get_players() -> Array[AbstractCharacter]:
	return get_characters().filter(func(c): return !c.is_ai)

func get_npcs() -> Array[AbstractCharacter]:
	return get_characters().filter(func(c): return c.is_ai)
