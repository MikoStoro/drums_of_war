extends Node
class_name BackendMessenger

@export var action_manager : ActionManager
@export var clock : BackendClock

var events_this_turn : Array[BaseEvent]

func _ready() -> void:
	clock.send_events.connect(send_events)

func receive_events(events: Array[BaseEvent]):
	handle_input_events(events)

func handle_input_events(events: Array[BaseEvent]):
	var input_events = get_events_by_type(events, GlobalEnums.event_type.INPUT)
	for event : PlayerInputEvent in (input_events as Array[PlayerInputEvent]):
		action_manager.apply_player_input(event)

func send_events():
	GlobalMessenger.send_message_to_frontend.emit(events_this_turn)
	events_this_turn.clear()

func add_event(event: BaseEvent):
	events_this_turn.append(event)

func add_events(events: Array[BaseEvent]):
	events_this_turn.append_array(events)


func get_events_by_type(events: Array[BaseEvent], event_type: GlobalEnums.event_type) -> Array[BaseEvent]:
	return events.filter( func (ev : BaseEvent): return ev.event_type == event_type )
 
func _ready() -> void:
	GlobalMessenger.send_message_to_backend.connect(receive_events)
