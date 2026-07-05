extends Summon
class_name BasicProjectile

var data : Dictionary


func _ready():
	self.controller = $ProjectileController
	self.x_pos = data["coordinates"].x
	self.y_pos = data["coordinates"].y
	self.direction = data["direction"]
	self.controller.action_direction = data["direction"]
	self.setup_entity()
	self.setup_visual()

func setup(data : Dictionary):
	self.data = data
	
	
