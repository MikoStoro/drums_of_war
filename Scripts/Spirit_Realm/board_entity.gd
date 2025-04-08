

class_name BoardEntity ## to-do: this should be some sort of base class, extended by actions???
var coordinates : Coordinates = Coordinates.new(0,0)
	
var moves  = []
var last_move : Move = null
## to-do: var attacks 

var correction_required : bool = false
var knockback_immunity : bool = false

var debug_display : String = "A"

var behavior : EntityBehavior = DefaultEntityBehavior.new(self)


func get_current_move() -> Move:
	if len(moves) > 0:
		return moves[0]
	else: return null
func get_last_move() -> Move:
	if last_move != null:
		return last_move
	else:
		return Move.new(Coordinates.new(0,0),false,0)
func pop_move() -> void:
	last_move = get_current_move()
	moves.pop_front()
func moves_left() -> int:
	return len(moves)
func turn_setup():
	behavior.turn_setup()
func collide(): ## to-do: make colliding entities able to interact
	behavior.collide()
func junction_collide():
	behavior.junction_collide()
