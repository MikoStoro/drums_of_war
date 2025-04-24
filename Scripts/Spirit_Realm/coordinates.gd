class_name Coordinates

const matrix90 = [[0,-1], [1,0]]
const matrix45 = [ [1, -1],[1, 1] ]
 
var x : float = 0
var y : float = 0
func _init(x : float, y: float) -> void:
	self.x = x
	self.y = y
func invert() -> Coordinates:
	self.x *= -1
	self.y *= -1
	return self

func add(other: Coordinates) -> Coordinates:
	return Coordinates.new(self.x + other.x, self.y + other.y)

func normalize():
	self.x = sign(x)
	self.y = sign(y)

func matrix_rotate(matrix):
	var tmp_x = matrix[0][0]*self.x + matrix[0][1]*self.y
	var tmp_y = matrix[1][0]*self.x + matrix[1][1]*self.y
	self.x = tmp_x
	self.y = tmp_y
	self.normalize()

func rotate(steps:int): ## step = 45 deg 
	for i in range(floor(steps / 2)):
		self.matrix_rotate(self.matrix90)
	if steps%2==1:
		self.matrix_rotate(self.matrix45)
