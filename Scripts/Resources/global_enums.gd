extends Resource
class_name GlobalEnums
enum event_type { 
	HIT, 
	DAMAGE, 
	COLLISION, 
	MOVE, 
	ATTACK_PROGRESS, 
	ATTACK_CLASH,
	DEATH, 
	INPUT, 
	BASE, 
	ATTACK_CREATION,
	ENTITY_SPAWN 
	}

enum directions {
	N = 0,
	NE = 1,
	E = 2,
	SE = 3,
	S = 4,
	SW = 5, 
	W = 6,
	NW = 7
}

enum summon_type { 
	basic_projectile 
	}
enum npc_type { 
	charger 
	}
