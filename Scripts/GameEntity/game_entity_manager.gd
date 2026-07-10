extends Node

var _active_entities: Dictionary[int, Node2D] = {}

func register_entity(id: int, entity_node: Node2D) -> void:
	_active_entities[id] = entity_node

func unregister_entity(id: int) -> void:
	_active_entities.erase(id)

func get_entity(id: int) -> Node2D:
	return _active_entities.get(id)
