class_name SummonProjectileAction
extends BaseAction

var summon_scene = preload("res://Scenes/projectile.tscn")

func perform_action(entity : BoardEntity,  direction:int = 0):
	entity.attack = null
	entity.moves = [ ]
	entity.behavior = BaseEntityBehaviour.new(entity)
	var v = Coordinates.new(1,0)
	v.rotate(direction)
	var c = entity.coordinates
	var starting_pos = Coordinates.new(c.x + v.x, c.y + v.y)
	var summon_data = { "coordinates" : starting_pos, "direction" : direction }
	entity.summon = { "type": GlobalEnums.summon_type.basic_projectile, "data" : summon_data }

func _init() -> void:
	self.action_name = "Summon Projectile"
	self.
