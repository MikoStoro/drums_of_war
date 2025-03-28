class_name Board
extends Node
class Coordinates: 
	var x : int = 0
	var y : int = 0
	func _init(x : int, y: int) -> void:
		self.x = x
		self.y = y
class BoardEntity:
	var coordinates : Coordinates = Coordinates.new(0,0)
	var move_direction : Coordinates = Coordinates.new(0,0)
	var move_distance : int = 0
	var debug_display : String = "A"
	func invert_direction():
		self.move_direction.x *= -1
		self.move_direction.y *= -1
	func collide():
		self.invert_direction()
		self.move_distance = 1
class Field:
	var x : int
	var y : int
	var entities : Array[BoardEntity] = []
	func get_debug_display() -> String:
		if len(entities) == 0: return "_"
		else: if len(entities) > 1: return "!"
		else: return entities[0].debug_display

const width = 5
const height = 5
var fields = Array()
var entities : Array[BoardEntity] = []
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

func update():
	print("TURN START")
	print_board()
	var move_performed = true
	while move_performed: ## will loop until there are no more moves to perform
		move_performed = false
		for e in entities: ## perform moves
			if e.move_distance > 0:
				move_performed = true
				move_entity(e)
		for e in entities: ## at the end of simulation round, check for collisions (multiple entities on the same field)
			if len(get_field(e.coordinates).entities) > 1:
				e.collide() ## if collisions are detected, run collide() method of board entity
		print_board()
		print("xxxxxxxxxxxx")
	


func get_field(coordinates: Coordinates) -> Field:
	return(fields[coordinates.x][coordinates.y])

func move_entity(entity : BoardEntity) -> void:
	var dir = entity.move_direction
	var new_coords = Coordinates.new(entity.coordinates.x + dir.x, entity.coordinates.y + dir.y)
	get_field(entity.coordinates).entities.erase(entity)
	entity.coordinates = new_coords
	get_field(entity.coordinates).entities.append(entity)
	entity.move_distance -= 1
	
func place_entity(entity: BoardEntity) -> void: ##DEBUG
	get_field(entity.coordinates).entities.append(entity)
	entities.append(entity)
	
func print_board():
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
	e1.move_distance = 1
	e1.move_direction = Coordinates.new(1,0)
	e1.coordinates = Coordinates.new(2,2)
	place_entity(e1)
	var e2 = BoardEntity.new()
	e2.debug_display = "B"
	e2.move_distance = 1
	e2.move_direction = Coordinates.new(-1,0)
	e2.coordinates = Coordinates.new(3,2)
	place_entity(e2)
