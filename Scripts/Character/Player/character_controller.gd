class_name CharacterController
extends Node

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


##to-do: change this to Array[Action] 
@onready var actions : Array[BaseAction] #= [ DashAction.new(), ThrustAction.new(), CleaveAction.new(), QuickStabAction.new() ]
@onready var default_action : BaseAction = DefaultIdleAction.new()

@onready var visual_character  = $"../VisualCharacter"
@onready var clock = GlobalComponents.clock
@onready var action_timer : Timer

var current_action: BaseAction = null

@onready var board : Board = GlobalComponents.abstract_board
var spirit : BoardEntity = null

func _ready() -> void:
	action_timer = $"ActionTimer"
	
	action_timer.wait_time = clock.beat_time * 0.4
	clock.beat.connect(_on_beat)
	clock.input_window_enter.connect(_input_window_enter)
	clock.input_window_leave.connect(_input_window_leave)
	action_timer.timeout.connect(_stop_action)

func change_state(new_state_str : String) -> void:
	var new_state_obj = states[new_state_str]
	last_state = state
	state = new_state_obj
	self.visual_character.apply_visual_effect(state.color)

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

func order_action(action):
	change_state("ORDERED")
	current_action = action
	print("Ordered: " + current_action.name)

func get_relative_mouse_position():
	return self.visual_character.get_relative_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##Action1 is pressed on-beat
	actions = get_parent().actions
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_1"):
		if (actions[0]!=null):
			order_action(actions[0])
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_2"):
		if (actions[1]!=null):  order_action(actions[1])
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_3"):
		if (actions[2]!=null): order_action(actions[2])
	if state == states["LISTENING"] && Input.is_action_just_pressed("invoke_action_4"):
		if (actions[3]!=null):  order_action(actions[3])
	##Action is pressed off-beat
	if state == states["BLOCKED"] && (Input.is_action_just_pressed("invoke_action_1") ||
		 Input.is_action_just_pressed("invoke_action_2")  || 
		 Input.is_action_just_pressed("invoke_action_3")  ||
		 Input.is_action_just_pressed("invoke_action_4")):
		change_state("MISSED")

func get_direction() -> int:
	return get_parent().visual.get_current_direction()


func _physics_process(delta: float) -> void:
	#move_and_slide()
	pass
	
func transfer_events(events: Array[BoardEvent]):
	$"../VisualCharacter".new_orders(events)
	
func link_spirit(e: BoardEntity):
	self.spirit = e
	e.controller = self



	
