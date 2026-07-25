
extends Node
class_name FrontendMessenger

func new_orders(arr: Array[BaseEvent]) -> void:
	for event: BaseEvent in arr:
		# event.execute() # maybe, instead of match event.type
		
		match event.get_type():
			GlobalEnums.event_type.HIT:
				var e : GameEntity = GameEntityManager.get_entity(0)
				e.recieve_hit(5)
				pass
			GlobalEnums.event_type.MOVE:
				_move(event.place[0])
			GlobalEnums.event_type.ATTACK_PROGRESS:
				_draw_line(event.place)	
			
# below are temp things from the old ways
func _draw_line(arr: Array[Vector2]):
	#player_animations.play(event.object.name)
	
	var line := Line2D.new()
	get_tree().root.add_child(line)
	line.width = 5
	line.default_color = Color(1, 1, 1, 0.1)
	line.texture_mode = line.LINE_TEXTURE_TILE	
	for pos in arr:
		line.add_point(pos)
	await get_tree().create_timer(0.2).timeout
	line.queue_free()
	
func _move(coords: Vector2) -> void:
	var new_position = coords
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 0.05) 
