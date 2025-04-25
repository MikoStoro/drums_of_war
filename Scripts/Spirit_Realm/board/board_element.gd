class_name BoardElement

var entities : Array[BoardEntity] = []
var attack_markers : Array[Attack] = []
var location: Coordinates

func _get_collision_events():
	var event_list : Array[BoardEvent] = []
	for e1 in entities:
		for e2 in entities:
			if e1 != e2:
				event_list.append(BoardEvent.new(BoardEvent.Event_type.CLASH, [e1,e2], location))
	return event_list

func _get_hit_events():
	var event_list : Array[BoardEvent] = []
	for e in entities:
		for a in attack_markers:
			event_list.append(BoardEvent.new(BoardEvent.Event_type.CLASH, [a,e], location))
	return event_list

func _get_clash_events() -> Array[BoardEvent]:
	var event_list : Array[BoardEvent] = []
	for a1 in attack_markers:
		for a2 in attack_markers:
			if a1 != a2:
				event_list.append(BoardEvent.new(BoardEvent.Event_type.CLASH, [a1,a2], location))
	return event_list

func process_clashes() -> Array[BoardEvent]:
	if len(attack_markers) > 1:
		for a in attack_markers:
			a.clash()
	return _get_clash_events()

func process_hits():
	if len(entities)>0 and len(attack_markers) > 0:
		for a in attack_markers:
			for e in entities:
				e.hit(a)
	return _get_hit_events()

func process_collisions():
	if len(entities) > 1:
		for e in entities:
			e.collide()
	return _get_collision_events()

func count_entities():
	return len(entities)

func count_attack_markers():
	return len(attack_markers)
