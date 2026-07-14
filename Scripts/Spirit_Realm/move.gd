class_name Move

var distance: int = 1
var direction: Coordinates = null
var teleport : bool = false

func _init(dir: Coordinates,tp: bool = false, dist : int = 1) -> void:
	self.distance = dist
	self.direction = dir
	self.teleport = tp

func rotate(rotation: int):
	self.direction.rotate(rotation)

static func fwd() -> Move:
	return Move.new(Coordinates.new(1,0))
