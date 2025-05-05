##SPIRIT REALM
class_name Board
extends Node




const width = 10
const height = 10
var fields = Array()
var entities : Array[BoardEntity] = []
var junctions : Dictionary[String, Junction] = {}
@onready var clock = $"../GlobalClock"

var events_this_round : Array[BoardEvent] = []
var attacked_fields : Array[Field] = []

func remove_duplicates(array: Array) -> Array:
	var unique: Array = []
	for item in array:
		if not unique.has(item):
			unique.append(item)
	return unique

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock.board_update.connect(update)
	fields = []
	for i in width:
		var row = []
		for j in height:
			var f = Field.new(i,j)
			row.append(f)
		fields.append(row)
	place_starting_entities()
	print_board()

func get_junction_name(field1:Field, field2:Field) -> String:
	var str1 = str((field1.x() + field2.x())/2)
	var str2 = str((field1.y() + field2.y())/2)
	if str1 < str2: return str1+str2
	else: return str2  + str1 ## this could have been avoided, if only gdscript implemented sets...

func update():
	events_this_round = []
	perform_movement_phase()
	perform_attack_phase()
	if len(events_this_round) > 0:
		print(events_this_round)
		pass
	##to-do: send events to the graphical layer 


func perform_movement_phase():
	print("TURN START")
	var move_performed = true
	var entities_moved: Array[BoardEntity] = []
	while move_performed: ## will loop until there are no more moves to perform
		move_performed = false
		junctions = {}
		for e in entities: e.turn_setup() ## setup new turn

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
		for f in fields_to_resolve: ## at the end of simulation round, check for collisions (multiple entities on the same field)
			var events = f.process_collisions() 
			self.events_this_round += events
	
	for e in remove_duplicates(entities_moved):
		events_this_round.append(BoardEvent.new(GlobalEnums.event_type.MOVE, e, e.coordinates.get_vector2()))
	print_board()

func get_attacks_by_priority(priority: int) -> Array[Attack]:
	var result : Array[Attack] = []
	for e in entities:
		if e.attack != null && e.attack.priority == priority:
			result.append(e.attack)
	return result

func perform_attack_phase():
	print("CHICKEN ATTAAAAACK")
	for priority in range(3): #check attacks of every priority in order
		junctions = {}
		attacked_fields = []
		var attacks : Array[Attack] = get_attacks_by_priority(priority)
		if len(attacks) == 0:
			continue
		var attacks_to_remove: Array[Attack] = []
		var update_performed = true
		while update_performed:
			update_performed = false
			var temp_attacks : Array[Attack] = []
			for a in attacks:
				if not a.is_finished():
					update_performed = true
					temp_attacks.append(a)
					mark_attack(a)
				else:
					attacks_to_remove.append(a)
			attacks = temp_attacks

			for j in junctions.values():  ##process clashes at junctions
				var events = j.process_clashes()
				self.events_this_round += events

			for a in attacks:
				if a.correction_required:
					unmark_attack(a)
			
			var fields_to_resolve = []
			for a in attacks:
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
			print_board()
		
		save_attack_events()
		
		for a in attacks_to_remove:
			remove_attack_from_board(a)
		attacks_to_remove = []
		junctions = {}

func save_attack_events():
	var events : Array[BoardEvent] = []
	for m in attacked_fields:
		var event = BoardEvent.new(GlobalEnums.event_type.ATTACK, m.attack_markers[0], m.location.get_vector2())
		events.append(event)
	events_this_round += events

func mark_attack(attack: Attack) -> void:
	var last_target = attack.get_last_target()
	var current_target = attack.get_current_target()
	if not out_of_bounds(current_target):
		last_target = get_field(last_target)
		current_target = get_field(current_target)
		current_target.attack_markers.append(attack)
		attacked_fields.append(current_target)
		get_junction(last_target, current_target).attack_markers.append(attack)

func unmark_attack(attack: Attack):
	var last_target = attack.get_current_target()
	if not out_of_bounds(last_target):
		var last_field = get_field(last_target)
		if(last_field.attack_markers.has(attack)):
			last_field.attack_markers.erase(attack)
		attacked_fields.erase(last_field)

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
		

func place_entity(entity: BoardEntity) -> void: ##DEBUG
	get_field(entity.coordinates).entities.append(entity)
	entities.append(entity)
	
func print_board(): ##DEBUG
	var print_string = ""
	for i in width:
		for j in height:
			print_string += fields[i][j].get_debug_display() + ' '
		print_string += "\n"
	print(print_string)

func place_starting_entities(): ##DEBUG
	var e1 = BoardEntity.new()
	#e1.moves = [ Move.new(Coordinates.new(1,0)), Move.new(Coordinates.new(1,0)), Move.new(Coordinates.new(1,0)) ]
	e1.coordinates = Coordinates.new(0,2)
	#e1.set_attack(ThrustAttack.new(0))
	#place_entity(e1)
	var e2 = BoardEntity.new()
	e2.debug_display = "B"
	#e2.moves = [ Move.new(Coordinates.new(-1,0)) ]
	e2.coordinates = Coordinates.new(1,2)
	e2.set_attack(ThrustAttack.new(4))
	#place_entity(e2)
