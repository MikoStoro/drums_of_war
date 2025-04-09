class_name Coordinates

var x : int = 0
var y : int = 0
func _init(x : int, y: int) -> void:
	self.x = x
	self.y = y
func invert() -> Coordinates:
	self.x *= -1
	self.y *= -1
	return self
