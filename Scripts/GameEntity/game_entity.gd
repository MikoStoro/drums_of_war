extends Node2D
class_name GameEntity
# BORN ANEW

@export var entity_data: GameEntityData
@export var sprite: Sprite2D
var backend_id := -1

signal hit_recieved(amount: int)

func setup(id: int) -> void:
	sprite.texture = entity_data.sprite
	backend_id = id

func recieve_hit(dmg : int) -> void:
	hit_recieved.emit(dmg)
	
# it should dispatch events to 
#  attack, indicator, hpbar
# this entity manager emits signal, for example taken damage
# entity and hpbar is interested

# draw lines (attack) should be another scene
# maybe one to play different resources (attacks) will be enough
	
# rotating direction indicator should be another script and scene
# probably as a child of character for realtive position

# and hp bar
