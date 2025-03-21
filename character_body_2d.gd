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
			"PRE-MOVE" : State.new("pre-move", Color(1,1,1))
			}
var state : State = states["LISTENING"]
var last_state : State = states["BLOCKED"]

@onready var clock = $"../GlobalClock"
@onready var action_timer : Timer = $ActionTimer
@onready var sprite = $Sprite2D

@onready var Action1 = $Actions/MoveRightAction
@onready var Action2 = $Actions/MoveLeftAction

const SPEED = 300.0
var dir = 1

var current_action = null

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

func _input_window_enter():
	if state == states["BLOCKED"]:
		change_state("LISTENING")
	if state == states["ORDERED"]:
		change_state("LISTENING")

func _input_window_leave():
	if state == states["LISTENING"] or state == states["MISSED"]:
		change_state("BLOCKED")
	if state == states["ORDERED"]:
		change_state("PRE-MOVE")

func _stop_action():
	current_action.end_action(self)
	change_state("BLOCKED")

func _on_beat():
	if state == states["PRE-MOVE"]:
		action_timer.start()
		current_action.perform_action(self)
		change_state("ACTION")
		dir *= -1

func perform_action(action):
	change_state("ORDERED")
	current_action = action
	print("Ordered: " + current_action.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	##Action1 is pressed on-beat
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_1"):
		perform_action(Action1)
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_2"):
		perform_action(Action2)
	##Action is pressed off-beat
	if state == states["BLOCKED"] && (Input.is_action_just_pressed("invoke_action_1") ||
		 Input.is_action_just_pressed("invoke_action_2")  || 
		 Input.is_action_just_pressed("invoke_action_3")  ||
		 Input.is_action_just_pressed("invoke_action_4")):
		change_state("MISSED")

func _physics_process(delta: float) -> void:
	'''if state == states.ACTION:
		velocity.x = dir * SPEED
	else:
		velocity.x = 0'''

	move_and_slide()
