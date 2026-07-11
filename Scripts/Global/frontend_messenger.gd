extends Node
class_name FrontendMessenger

func new_orders(arr: Array[BoardEvent]) -> void:
	for event: BoardEvent in arr:
		# event.execute() # instead of match event.type
		
		#event = _adapt_event_to_visual_realm(event)
		
		match event.type:
			GlobalEnums.event_type.HIT:
				var e : GameEntity = GameEntityManager.get_entity(0)
				e.recieve_hit(5)
				pass
