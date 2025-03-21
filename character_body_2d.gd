extends CharacterBody2D
class State:
	var name: String
	var color: Color
	func _init(name: String, color: Color) -> void:
		self.name = name
		self.color = color
			

const SPEED = 300.0

var states = {"LISTENING": State.new("Listening", Color(1,1,1)),
			"BLOCKED": State.new("Blocked", Color(1,1,1)),
			"ORDERED": State.new("Ordered", Color(0.5,0.5,0.25)),
			"ACTION": State.new("Moving", Color(1,1,1)),
			"MISSED" : State.new("Missed", Color(1.5,1,1)),
			"PRE-MOVE" : State.new("Missed", Color(1,1,1))
			}
var state : State = states["LISTENING"]
var last_state : State = states["BLOCKED"]

const move_dist = 25
var clock
var action_timer : Timer
var dir = 1
var sprite
var in_input_window = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock = $"../GlobalClock"
	action_timer = $ActionTimer
	sprite = $Sprite2D
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
	in_input_window = true
	if state == states["BLOCKED"]:
		change_state("LISTENING")
	if state == states["ORDERED"]:
		change_state("LISTENING")

func _input_window_leave():
	in_input_window = false
	if state == states["LISTENING"] or state == states["MISSED"]:
		change_state("BLOCKED")
	if state == states["ORDERED"]:
		change_state("PRE-MOVE")

func _stop_action():
	change_state("BLOCKED")

func _on_beat():
	if state == states["PRE-MOVE"]:
		action_timer.start()
		change_state("ACTION")
		dir *= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if state == states["LISTENING"] && Input.is_action_just_pressed("ui_accept"):
		change_state("ORDERED")
		print("move ordered")
	if state == states["BLOCKED"] && Input.is_action_just_pressed("ui_accept"):
		change_state("MISSED")
		print("missed")

func _physics_process(delta: float) -> void:
	if state == states.ACTION:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
