extends BaseAction
class_name BaseAttackAction

var attack : String = Attacks.STAB

func perform_action(entity : BoardEntity, direction: int = 0):
	super(entity, direction)
	entity.set_attack(AttackFactory.get_attack(self.attack,direction))
