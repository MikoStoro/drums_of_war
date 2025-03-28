extends Sprite2D

var clock
var beat 
var sprite 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	clock = $"../GlobalClock"
	beat = $beat
	sprite = $Sprite2D
	clock.beat.connect(enlarge)
	beat.timeout.connect(shrink)

func enlarge():
	sprite.apply_scale(Vector2(1.25,1.25))
	beat.start()
	
	
func shrink():
	sprite.apply_scale(Vector2(0.8,0.8))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
