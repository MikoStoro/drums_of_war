extends Node
class_name FrontendMessenger

func new_orders(arr: Array[BoardEvent]) -> void:
	for event: BoardEvent in arr:
		#event = _adapt_event_to_visual_realm(event)
		
		match event.type:
			GlobalEnums.event_type.HIT:
				var e : GameEntity = GameEntityManager.get_entity(id)
				
				pass
				#_recieve_hit(event.extra_data[0].damage_taken)
				#$CharacterSprite/HitSparks.emitting = true	#it most likely should be handled in weapon 

			#GlobalEnums.event_type.MOVE:
				#_move(event.place[0])	#Move always should have only one element, so its function takes only one
			#GlobalEnums.event_type.ATTACK:
				#_draw_line(event.place, event)
			#GlobalEnums.event_type.COLLISION:
				#$CharacterSprite/CollisionSparks.emitting = true
				#var pos = position
				#_move(event.place[0])
				#_move(pos)
