class_name DefaultAttackBehavior
extends EntityBehavior


func turn_setup():
	e.knockback_immunity = true
	e.correction_required = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
