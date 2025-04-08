class_name Character
extends CharacterBody2D

class State:
	var name: String
	var color: Color
	func _init(name: String, color: Color) -> void:
		self.name = name
		self.color = color

var states = {"LISTENING": State.new("Listening", Color(1,1,1)),
			"BLOCKED": State.new("Blocked", Color(1,1,1)),
			"ORDERED": State.new("Ordered", Color(0.5,0.5,0.25)),
			"ACTION": State.new("Moving", Color(1,1,1)),
			"MISSED" : State.new("Missed", Color(1.5,1,1)),
			"PRE-ACTION" : State.new("pre-move", Color(1,1,1))
			}
var state : State = states["LISTENING"]
var last_state : State = states["BLOCKED"]

@onready var clock = $"../GlobalClock"
@onready var action_timer : Timer = $ActionTimer
@onready var sprite = $Sprite2D

@onready var Action1 = RightAction.new()
@onready var Action2 = null
@onready var Action3 = null
@onready var Action4 = null

const SPEED = 300.0
var dir = 1

var current_action: BaseAction = null

@onready var board : Board = $Board
var spirit : BoardEntity = null

func _ready() -> void:
	action_timer.wait_time = clock.beat_time * 0.4
	clock.beat.connect(_on_beat)
	clock.input_window_enter.connect(_input_window_enter)
	clock.input_window_leave.connect(_input_window_leave)
	action_timer.timeout.connect(_stop_action)

func change_state(new_state_str : String) -> void:
	var new_state_obj = states[new_state_str]
	last_state = state
	state = new_state_obj
	sprite.modulate = state.color

#to be overriden
func _input_window_enter():
	pass
	
#to be overriden
func _input_window_leave():
	pass

#to be overriden
func _stop_action():
	pass

#to be overriden
func _on_beat():
	pass

func perform_action(action):
	change_state("ORDERED")
	current_action = action
	print("Ordered: " + current_action.name)

func get_relative_mouse_position():
	return get_global_mouse_position() - position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##Action1 is pressed on-beat
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_1"):
		if (Action1!=null):
			perform_action(Action1)
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_2"):
		if (Action2!=null):  perform_action(Action2)
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_3"):
		if (Action3!=null): perform_action(Action3)
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_4"):
		if (Action4!=null):  perform_action(Action4)
	##Action is pressed off-beat
	if state == states["BLOCKED"] && (Input.is_action_just_pressed("invoke_action_1") ||
		 Input.is_action_just_pressed("invoke_action_2")  || 
		 Input.is_action_just_pressed("invoke_action_3")  ||
		 Input.is_action_just_pressed("invoke_action_4")):
		change_state("MISSED")

func _physics_process(delta: float) -> void:
	move_and_slide()

	
