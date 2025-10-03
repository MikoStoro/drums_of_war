##SPIRIT REALM
class_name Board
extends Node


var width = 10
var height = 10
var fields = Array()
var entities : Array[BoardEntity] = []
var junctions : Dictionary[String, Junction] = {}
@onready var clock = GlobalComponents.clock

var debug_print = true
var events_this_round : Array[BoardEvent] = []

func remove_duplicates(array: Array) -> Array:
	var unique: Array = []
	for item in array:
		if not unique.has(item):
			unique.append(item)
	return unique

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalComponents.abstract_board = self
	clock.board_update.connect(update)
	reset_board()
	


func get_junction_name(field1:Field, field2:Field) -> String:
	var x1 = field1.x()
	var x2 = field2.x()
	var y1 = field1.y()
	var y2 = field2.y()
	var strx = ""
	var stry = ""
	
	if x1 < x2: strx = str(x1) + " " + str(x2)
	else: strx = str(x2) + " " + str(x1)
	
	if y1 < y2: stry = str(y1) + " " + str(y2)
	else: stry = str(y2) + " " + str(y1)
	
	return strx + " " + stry
	## this could have been avoided, if only gdscript implemented sets...

func get_affected_entities(events: Array[BoardEvent]):
	var ents:Array[BoardEntity] = []
	for ev in events:
		var en = ev.get_affected_entities()
		if en is Array:
			ents += en
		else: ents.append(en)
	return ents
	

func update():
	print(entities)
	events_this_round = []
	perform_movement_phase()
	perform_attack_phase()
	if len(events_this_round) > 0:
		print(events_this_round)
		var temp_entities = get_affected_entities(events_this_round)
		for en in temp_entities:
			if en != null:	#TODO why is it null
				var events_for_this_entity : Array[BoardEvent] = []
				for ev in events_this_round:
					if ev.affects_entity(en): events_for_this_entity.append(ev)
				en.transfer_events(events_for_this_entity)
				#temp_player.new_orders(events_this_round)


func perform_movement_phase():
	if debug_print : ("TURN START")
	var move_performed = true
	var entities_moved: Array[BoardEntity] = []
	var iterations = 0
	while move_performed: ## will loop until there are no more moves to perform
		iterations+=1
		if (iterations > 25):
			break ##CIRCUIT BREAKER - MIGHT CAUSE PROBLEMS
		move_performed = false
		junctions = {}
		for e in entities: e.turn_setup() ## setup new turn
		
		if (len(entities.filter(func(e) : return e.moves_left() > 0)) > 1):
			pass

		for e in entities: ## perform moves
			if e.moves_left() > 0:
				move_performed = true
				move_entity(e)
				entities_moved.append(e)

		for j in junctions.values():  ##hell yeah
			var events = j.process_collisions() 
			self.events_this_round += events

		for e in entities: ##corect positions after junction collisions
			if e.correction_required and e.moves_left() > 0:
				move_entity(e) ## to-do: add move events

		var fields_to_resolve = []
		for e in entities:
			fields_to_resolve.append(get_field(e.coordinates))
		fields_to_resolve = remove_duplicates(fields_to_resolve)
		for f  in fields_to_resolve: ## at the end of simulation round, check for collisions (multiple entities on the same field)
			var events = f.process_collisions() 
			self.events_this_round += events
	
	for e in remove_duplicates(entities_moved):
		events_this_round.append(BoardEvent.new(GlobalEnums.event_type.MOVE, e, [e.coordinates.get_vector2()]))
		e.update_attack_targets()
		
	print_board(debug_print)

func get_attacks_by_priority(priority: int) -> Array[Attack]:
	var result : Array[Attack] = []
	for e in entities:
		if e.attack != null && e.attack.priority == priority:
			result.append(e.attack)
	return result

func perform_attack_phase():
	if debug_print: ("CHICKEN ATTAAAAACK")
	for priority in range(3): #check attacks of every priority in order
		junctions = {}
		var attacks : Array[Attack] = get_attacks_by_priority(priority)
		if len(attacks) == 0:
			continue
		var resolved_attacks: Array[Attack] = []
		var update_performed = true
		while update_performed:
			update_performed = false
			var temp_attacks : Array[Attack] = []
			for a in attacks:
				if not a.is_finished():
					update_performed = true
					var mark_success = mark_attack(a)
					if mark_success:
						temp_attacks.append(a)
					else:
						a.finished = true
						resolved_attacks.append(a)
				else:
					resolved_attacks.append(a)
			attacks = temp_attacks

			for j in junctions.values():  ##process clashes at junctions
				var events = j.process_clashes()
				self.events_this_round += events

			for a in attacks:
				if a.correction_required:
					unmark_attack(a)
			
			var fields_to_resolve = []
			for a in attacks:
				var current_target = a.get_current_target()
				if not out_of_bounds(current_target):
					fields_to_resolve.append(get_field(a.get_current_target()))
			fields_to_resolve = remove_duplicates(fields_to_resolve)
			
			for f in fields_to_resolve: #process hits on fields
				var events = f.process_hits()
				self.events_this_round += events
					
			for f in fields_to_resolve: #process clashes on fields
				var events = f.process_clashes()
				self.events_this_round += events
			
			for a in attacks:
				a.pop_target()
			print_board(debug_print)
		
		events_this_round += get_attack_events(resolved_attacks)
		
		for a in resolved_attacks:
			remove_attack_from_board(a)
		resolved_attacks = []
		junctions = {}

func get_attack_events(attacks : Array[Attack]) -> Array[BoardEvent]:
	var events : Array[BoardEvent] = []
	for a in attacks:
		var location_list : Array[Vector2] = []
		for i in range(len(a.targets)):
			if i == a.current_target:
				break
			var t = a.targets[i]
			location_list.append(t.get_vector2())
		if len(location_list) > 0:
			location_list.push_front(a.user_coordinates.get_vector2())
			var event = BoardEvent.new(GlobalEnums.event_type.ATTACK, a, location_list)
			events.append(event)
	return events
	
func mark_attack(attack: Attack) -> bool:   ## true if able to mark attack
	var last_target = attack.get_last_target()
	var current_target = attack.get_current_target()
	if not out_of_bounds(current_target):
		last_target = get_field(last_target)
		current_target = get_field(current_target)
		current_target.attack_markers.append(attack)
		get_junction(last_target, current_target).attack_markers.append(attack)
		return true
	else: return false

func unmark_attack(attack: Attack):
	var last_target = attack.get_current_target()
	if not out_of_bounds(last_target):
		var last_field = get_field(last_target)
		if(last_field.attack_markers.has(attack)):
			last_field.attack_markers.erase(attack)

func remove_attack_from_board(attack: Attack) -> void:
	for t in attack.targets:
		if not out_of_bounds(t):
			var field = get_field(t)
			field.reset_attack_markers()




func get_field(coordinates: Coordinates) -> Field:
	return(fields[coordinates.x][coordinates.y])

func out_of_bounds(coordinates : Coordinates) -> bool:
	if coordinates.x < 0 || coordinates.y < 0 || coordinates.x > width-1 || coordinates.y > height-1:
		return true
	return false

func move_entity(entity : BoardEntity) -> void:
	var move = entity.get_current_move()
	var dir = move.direction
	var dist = move.distance
	var new_coords = Coordinates.new(entity.coordinates.x + dir.x*dist, entity.coordinates.y + dir.y*dist)
	
	if out_of_bounds(new_coords):
		entity.stop()
		return
	
	var old_field = get_field(entity.coordinates)
	old_field.entities.erase(entity)
	entity.coordinates = new_coords
	
	var new_field = get_field(entity.coordinates)
	new_field.entities.append(entity)
	entity.pop_move()
	
	if move.teleport == false: ##add junction between old and new field
		#var junction_name = get_junction_name(old_field, new_field)
		#get_junction(junction_name).entities.append(entity)
		get_junction(old_field, new_field).entities.append(entity)

func get_junction(old: Field, new: Field) -> Junction:
	var name = get_junction_name(old, new)
	var junction = null
	if junctions.has(name) == false:
		junction = Junction.new(old.location, new.location)
		junctions[name] = junction
	else:
		junction = junctions[name]
	return junction
		

func place_entity(entity: BoardEntity) -> void:
	get_field(entity.coordinates).entities.append(entity)
	entities.append(entity)
	print_board(debug_print)
	
func print_board(debug : bool = true): ##DEBUG
	if not debug: return
	var print_string = ""
	for i in width:
		for j in height:
			print_string += fields[i][j].get_debug_display() + ' '
		print_string += "\n"
	print(print_string)

func reset_board(x:int = 10, y:int=10):
	fields = []
	self.width = x
	self.height = y
	for j in width:
		var row = []
		for i in height:
			var f = Field.new(j,i)
			row.append(f)
		fields.append(row)
	print_board(debug_print)
