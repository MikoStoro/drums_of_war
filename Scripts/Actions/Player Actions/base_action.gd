class_name BaseAction extends Node

var action_name : String  = "base_action"
var behaviour : String  = EntityBehaviours.DEFAULT_IDLE_BEHAVIOUR
var moves = []

func rotate_moves(direction: int):
	for m in self.moves:
		m.rotate(direction)

func perform_action(entity : BoardEntity, direction: int = 0):
	entity.attack = null
	entity.moves = self.moves
	entity.rotate_moves(direction)
	entity.behavior = BehaviourFactory.get_behaviour(self.behaviour, entity)

func end_action(character):
	pass
