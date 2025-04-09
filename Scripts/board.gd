##SPIRIT REALM
class_name Board
extends Node
class Coordinates: 
	var x : int = 0
	var y : int = 0
	func _init(x : int, y: int) -> void:
		self.x = x
		self.y = y
	func invert() -> Coordinates:
		self.x *= -1
		self.y *= -1
		return self


class Move:
	var distance: int = 1
	var direction: Coordinates = null
	var teleport : bool = false

	func _init(dir: Coordinates,teleport: bool = false, dist : int = 1) -> void:
		self.distance = dist
		self.direction = dir
		self.teleport = teleport

class BoardEntity: ## to-do: this should be some sort of base class, extended by actions???
	var coordinates : Coordinates = Coordinates.new(0,0)
	
	var moves  = []
	var last_move : Move = null
	## to-do: var attacks 
	
	var correction_required : bool = false
	var knockback_immunity : bool = false
	
	var debug_display : String = "A"
	
	func get_current_move() -> Move:
		if len(moves) > 0:
			return moves[0]
		else: return null
	func get_last_move() -> Move:
		if last_move != null:
			return last_move
		else:
			return Move.new(Coordinates.new(0,0),false,0)
	func pop_move() -> void:
		last_move = get_current_move()
		moves.pop_front()
	func moves_left() -> int:
		return len(moves)
	func turn_setup():
		self.correction_required = false
		self.knockback_immunity = false
	func collide(): ## to-do: make colliding entities able to interact
		if not knockback_immunity:
			self.moves = [Move.new(get_last_move().direction.invert())]
	func junction_collide():
		var current_move = get_current_move()
		self.moves = [Move.new(get_last_move().direction.invert(),true)] 
		self.knockback_immunity = true
		self.correction_required = true
		
class Field:
	var x : int
	var y : int
	var entities : Array[BoardEntity] = []

	func get_debug_display() -> String:
		if len(entities) == 0: return "_"
		else: if len(entities) > 1: return "!"
		else: return entities[0].debug_display
	func count_colliding_entities():
		return len(entities)
		'''var count = 0
		for e in entities:
			if e.able_to_collide: count += 1
		return count'''
		
class Junction:
	var entities : Array[BoardEntity] = []
	func process_collisions():
		if len(entities) > 1:
			for e in entities: e.junction_collide()
	func clear():
		entities = []

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

func perform_attack_phase():
	pass

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
			if get_field(e.coordinates).count_colliding_entities() > 1:
				e.collide() ## if collisions are detected, run collide() method of board entity

	print_board()


func get_field(coordinates: Coordinates) -> Field:
	return(fields[coordinates.x][coordinates.y])

func move_entity(entity : BoardEntity) -> void:
	var move = entity.get_current_move()
	var dir = move.direction
	var dist = move.distance
	var new_coords = Coordinates.new(entity.coordinates.x + dir.x*dist, entity.coordinates.y + dir.y*dist)
	
	var old_field = get_field(entity.coordinates)
	old_field.entities.erase(entity)
	entity.coordinates = new_coords
	
	var new_field = get_field(entity.coordinates)
	new_field.entities.append(entity)
	entity.pop_move()
	
	if move.teleport == false: ##add junction between old and new field
		var junction_name = get_junction_name(old_field, new_field)
		if junctions.has(junction_name) == false:
			var junction = Junction.new()
			junction.entities.append(entity)
			junctions[junction_name] = junction
		else:
			junctions[junction_name].entities.append(entity)
	
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func place_starting_entities(): ##DEBUG
	var e1 = BoardEntity.new()
	e1.moves = [ Move.new(Coordinates.new(1,0)), Move.new(Coordinates.new(1,0)), Move.new(Coordinates.new(1,0)) ]
	e1.coordinates = Coordinates.new(0,2)
	place_entity(e1)
	var e2 = BoardEntity.new()
	e2.debug_display = "B"
	#e2.moves = [ Move.new(Coordinates.new(-1,0)) ]
	e2.coordinates = Coordinates.new(3,2)
	place_entity(e2)
