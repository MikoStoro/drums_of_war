extends Summon
class_name BasicProjectile

var data : Dictionary


func _ready():
	self.controller = $ProjectileController
	var test = get_children()
	self.x_pos = data["coordinates"].x
	self.y_pos = data["coordinates"].y
	self.controller.action_direction = data["direction"]
	self.setup_entity()

func setup(data : Dictionary):
	self.data = data
	
	
