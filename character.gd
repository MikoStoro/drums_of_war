extends Node2D


enum states {AWAITING, MOVING}
var state : states = states.AWAITING

const move_dist = 25
var clock : Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock = $"../GlobalClock"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("ui_accept"):
		
	
