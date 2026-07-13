extends Node
class_name ActionManager

@export var character_manager : CharacterManager
@export var clock : BackendClock

func _ready() -> void:
	clock.input_window_start.connect(reset_actions)
	clock.input_window_end.connect(perform_actions)

func apply_player_input(event : PlayerInputEvent):
	var target : PlayerAbstractCharacter = character_manager.get_character_by_id(event.target_entity_id)
	target.setup_action(event.action_index, event.action_direction)

## this causes AI to setup their actions and players to return to default action	
func reset_actions(): 
	for c : AbstractCharacter in character_manager.get_characters():
		c.reset_action()
	setup_npc_actions()

func setup_npc_actions():
	for c : NpcAbstractCharacter in character_manager.get_npcs():
		c.setup_action()

## this LOADS the actions to spirits so they can be performed during abstractboard's turn
func perform_actions():
	for c : AbstractCharacter in character_manager.get_characters():
		c.perform_action() 
