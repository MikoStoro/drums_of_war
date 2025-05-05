class_name BoardElement

var entities : Array[BoardEntity] = []
var attack_markers : Array[Attack] = []
var clash_resolved : Array[Attack] = []
var location: Coordinates

func _get_collision_events():
	var event_list : Array[BoardEvent] = []
	for e1 in entities:
		for e2 in entities:
			if e1 != e2:
				event_list.append(BoardEvent.new(GlobalEnums.event_type.CLASH, [e1,e2], location.get_vector2()))
	return event_list

func _get_hit_events(hit_pairs: Array):
	var event_list : Array[BoardEvent] = []
	for h in hit_pairs:
		event_list.append(BoardEvent.new(GlobalEnums.event_type.CLASH, h, location.get_vector2()))
	return event_list

func _get_clash_events(attack_pairs : Array) -> Array[BoardEvent]:
	var event_list : Array[BoardEvent] = []
	for a in attack_pairs:
		event_list.append(BoardEvent.new(GlobalEnums.event_type.CLASH, a, location.get_vector2()))
	return event_list

func perform_clash(a1: Attack, a2: Attack):
	a1.clash(a2)

func perform_collide(e1: BoardEntity, e2: BoardEntity):
	e1.collide(e2)

func process_clashes() -> Array[BoardEvent]:
	var clashed :  = []
	if len(attack_markers) > 1:
		for a1 in attack_markers:
			if not a1.is_finished() and a1 not in clash_resolved:
				for a2 in attack_markers:
					if a1 != a2:
						perform_clash(a1, a2) ## attack a1 clashes with attack a2
						clash_resolved.append(a1)
						clashed.append([a1,a2])
	return _get_clash_events(clashed)

func reset_attack_markers():
	self.attack_markers = []
	self.clash_resolved = []

func process_hits():
	var hits = []
	if len(entities)>0 and len(attack_markers) > 0:
		for a in attack_markers:
			for e in entities:
				e.hit(a)
				hits.append([e,a])
	return _get_hit_events(hits)

func process_collisions():
	if len(entities) > 1:
		for e in entities:
			e.collide()
	return _get_collision_events()

func count_entities():
	return len(entities)

func count_attack_markers():
	return len(attack_markers)
	
