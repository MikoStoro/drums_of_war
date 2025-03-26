class_name Board
extends Node

class Field:
	var x : int
	var y : int
	var content : Node = null
	var debug_description : String = "x"
class Move:
	var start: Field
	var end: Field
class Attack:
	var target: Field

const width = 5
const height = 5
var fields = Array()
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
			f.content = null
			row.append(f)
		fields.append(row)

func update():
	print_board()
	
func print_board():
	var print_string = ""
	for i in width:
		for j in height:
			print_string += fields[i][i].debug_description + ' '
		print_string += "\n"
	print(print_string)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
