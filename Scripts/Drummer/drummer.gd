extends Node
@onready var clock = $"../GlobalClock"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clock.beat.connect(beat)

func beat():
	print("AAAA")
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
