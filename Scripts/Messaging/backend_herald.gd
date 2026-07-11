extends Node
class_name BackendMessenger

@export var character_manager: CharacterManager

func receive_events(events: Array[BaseEvent]):
	handle_input_events(get_events_by_type(events,GlobalEnums.event_type.INPUT))

func handle_input_events(events: Array[BaseEvent]):
	character_manager

func send_events(events: Array[BaseEvent]):
	GlobalMessenger.send_message_to_frontend.emit(events)

func get_events_by_type(events: Array[BaseEvent], event_type: GlobalEnums.event_type) -> Array[BaseEvent]:
	return events.filter( func (ev : BaseEvent): return ev.event_type == event_type )
 
func _ready() -> void:
	GlobalMessenger.send_message_to_backend.connect(receive_events)
