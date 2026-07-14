class_name BoardEntity
var coordinates : Coordinates = Coordinates.new(0,0)
var last_coordinates : Coordinates = null
signal destroyed

var mark_for_removal: bool = false

var moves  = []
var last_move : Move = null
var attack : Attack = null
var summon : Dictionary = {}

var health : int = 3

var moved_this_turn : int = 0
var solid : bool = true

var debug_display : String = "A"
signal new_events(events)

var behavior : BaseEntityBehaviour = DefaultMoveBehavior.new(self)

var character_id : int

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

func get_last_coordinates() -> Coordinates:
	return self.last_coordinates

func update_coordinates(c: Coordinates) -> void:
	self.last_coordinates = self.coordinates
	self.coordinates = c

func pop_move() -> void:
	last_move = get_current_move()
	moves.pop_front()
	
func moves_left() -> int:
	return len(moves)
	
func turn_setup():
	last_coordinates = null
	behavior.turn_setup()
	
func round_setup():
	moved_this_turn = 0
	
func collide(other : BoardEntity = null): ## to-do: make colliding entities able to interact
	return behavior.collide(other)
	
func hit(attack) -> Array[BaseEvent]:
	var attack_result = behavior.hit(attack)
	return attack_result
	
func hit_direct(damage: int) -> Array[BaseEvent]:
	var hit_result = behavior.hit_direct(damage)
	return hit_result
	
func stop():
	behavior.stop()
	
func junction_collide(other: BoardEntity = null):
	return behavior.junction_collide(other)
	
func set_attack(attack: Attack):
	self.attack = attack
	attack.apply_blueprint(self)

func reset_attack():
	self.attack = null

func _to_string():
	return self.debug_display
	

func _init(character_id : int, display_symbol : String ):
	display_symbol = display_symbol[0] ## symbol must be 1 character long or it will fuck up the board
	self.character_id = character_id
	self.coordinates = Coordinates.new(-1,-1)
	self.debug_display = display_symbol
	
func update_attack_targets():
	if attack != null:
		attack.apply_blueprint(self)

func death():
	print("DETH: " + debug_display)
	self.mark_for_removal = true
	emit_signal("destroyed")
	
func hit_board_border():
	self.behavior.hit_board_border()
