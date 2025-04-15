##SPIRIT REALM
class_name Board
extends Node




const width = 5
const height = 5
var fields = Array()
var entities : Array[BoardEntity] = []
var junctions : Dictionary[String, Junction] = {}
@onready var clock = $"../GlobalClock"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock.board_update.connect(update)
	fields = []
	for i in width:
		var row = []
		for j in height:
			var f = Field.new()
			f.x = i
			f.y = j
			row.append(f)
		fields.append(row)
	place_starting_entities()
	print_board()

func get_junction_name(field1:Field, field2:Field) -> String:
	var str1 = str(field1.x) + str(field1.y)
	var str2 = str(field2.x) + str(field2.y)
	if str1 < str2: return str1+str2
	else: return str2  + str1 ## this could have been avoided, if only gdscript implemented sets...

func update():
	perform_movement_phase()
	perform_attack_phase()

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
		var attacks : Array[Attack] = get_attacks_by_priority(priority)
		var attacks_to_unmark: Array[Attack] = []
		var update_performed = true
		while update_performed:
			update_performed = false
			for a in attacks:
				if not a.is_finished():
					update_performed = true
					mark_attack(a)
				else:
					attacks.erase(a)
					attacks_to_unmark.append(a)
		
			for j in junctions.values():  ##process clashes at junctions
				j.process_clashes()
			
			for a in attacks:
				if a.correction_required:
					unmark_attack(a)
		
			for a in attacks: #process hits on fields
				get_field(a.get_current_target()).process_hits()
					
			for a in attacks: #process clashes on fields
				get_field(a.get_current_target()).process_clashes()
			
			for a in attacks:
				a.pop_target()
			print_board()
		for a in attacks_to_unmark:
			unmark_attack_completely(a)
		junctions = {}
			

func mark_attack(attack: Attack) -> void:
	var last_target = attack.get_last_target()
	var current_target = attack.get_current_target()
	if not out_of_bounds(current_target):
		last_target = get_field(last_target)
		current_target = get_field(current_target)
		current_target.attack_markers.append(attack)
		var junction_name = get_junction_name(last_target, current_target)
		get_junction(junction_name).attack_markers.append(attack)

func unmark_attack(attack: Attack):
	var last_target = attack.get_last_target()
	if not out_of_bounds(last_target):
		var last_field = get_field(last_target)
		if(last_field.attack_markers.has(attack)):
			last_field.attack_markers.erase(attack)

func unmark_attack_completely(attack: Attack) -> void:
	for t in attack.targets:
		if not out_of_bounds(t):
			var field = get_field(t)
			if(field.attack_markers.has(attack)):
				field.attack_markers.erase(attack)

func perform_movement_phase():
	print("TURN START")
	var move_performed = true

	while move_performed: ## will loop until there are no more moves to perform
		move_performed = false
		junctions = {}
		for e in entities: e.turn_setup() ## setup new turn

		for e in entities: ## perform moves
			if e.moves_left() > 0:
				move_performed = true
				move_entity(e)

		for j in junctions.values():  ##hell yeah
			j.process_collisions() 

		for e in entities: ##corect positions after junction collisions
			if e.correction_required and e.moves_left() > 0:
				move_entity(e)

		for e in entities: ## at the end of simulation round, check for collisions (multiple entities on the same field)
			if get_field(e.coordinates).count_entities() > 1:
				e.collide() ## if collisions are detected, run collide() method of board entity
	print_board()


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
		var junction_name = get_junction_name(old_field, new_field)
		get_junction(junction_name).entities.append(entity)

func get_junction(name: String) -> Junction:
	var junction = null
	if junctions.has(name) == false:
		junction = Junction.new()
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
	e1.set_attack(ThrustAttack.new())
	place_entity(e1)
	var e2 = BoardEntity.new()
	e2.debug_display = "B"
	#e2.moves = [ Move.new(Coordinates.new(-1,0)) ]
	e2.coordinates = Coordinates.new(2,2)
	place_entity(e2)
