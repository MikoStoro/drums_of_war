class_name BoardEntity
var coordinates : Coordinates = Coordinates.new(0,0)
	
var moves  = []
var last_move : Move = null
var attack : Attack = null

var health : int = 3

var correction_required : bool = false
var knockback_immunity : bool = false

var debug_display : String = "A"

var behavior : EntityBehavior = DefaultMoveBehavior.new(self)

var controller : CharacterController = null

func rotate_moves(direction: int):
	for m in self.moves:
		m.rotate(direction)
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
func collide(other : BoardEntity = null): ## to-do: make colliding entities able to interact
	behavior.collide(other)
func hit(attack):
	var attack_result = behavior.hit(attack)
	return attack_result
	
func stop():
	behavior.stop()
func junction_collide(other: BoardEntity = null):
	behavior.junction_collide(other)
func set_attack(attack: Attack):
	self.attack = attack
	attack.apply_blueprint(self)
func reset_attack():
	self.attack = null
func _to_string():
	return self.debug_display
func transfer_events(events : Array[BoardEvent]):
	self.controller.transfer_events(events)
func _init(s_x:float=0, s_y:float=0):
	self.coordinates = Coordinates.new(s_x,s_y)
func update_attack_targets():
	if attack != null:
		attack.apply_blueprint(self)
func die():
	print("DETH: " + debug_display)
