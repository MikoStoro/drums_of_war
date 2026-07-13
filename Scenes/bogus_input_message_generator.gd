extends Node

var direction : int= 0
@export var messenger: BackendMessenger

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			print("T was pressed")
		if event.keycode == KEY_2:
			print("T was pressed")
		if event.keycode == KEY_3:
			print("T was pressed")
		if event.keycode == KEY_4:
			print("T was pressed")
		if event.keycode == KEY_RIGHT:
			direction = GlobalEnums.directions.E
		if event.keycode == KEY_LEFT:
			direction = GlobalEnums.directions.W
		if event.keycode == KEY_UP:
			direction = GlobalEnums.directions.N
		if event.keycode == KEY_DOWN:
			direction = GlobalEnums.directions.S
