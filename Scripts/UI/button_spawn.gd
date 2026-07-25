extends Button
@export var x:TextEdit
@export var y:TextEdit
@export var is_ai:CheckBox
@export var input_type: OptionButton
const GAMEPAD_CONTROLS = preload("uid://csujaolyhb3um")
const KEYBOARD_CONTROLS = preload("uid://bt6roi0syja4i")

enum InputMode {
	KEYBOARD,
	CONTROLLER
}

func _ready():
	var modes = {
		InputMode.KEYBOARD: "KEYBOARD",
		InputMode.CONTROLLER: "CONTROLLER",
	}

	for mode in modes.keys():
		input_type.add_item(modes[mode])
		input_type.set_item_metadata(input_type.item_count - 1, mode)


func _on_button_down() -> void:
	var data = {"x" = int(x.text), "y" = int(y.text)}
	var e = EntityCreationEventToBackend.new(data)
	GlobalMessenger.emit.send_message_to_backend(e)
	
	var gev = GameEntityVisual.new()
	var ged = GameEntityData.new()
	ged.sprite = "res://Assets/Sprites/druns_of_war_sprite_hi_res.png"
	gev.entity_data = ged
	add_child(gev)
	
	var mode
	#if is_ai.button_pressed:
		#z.add_npc(GlobalEnums.npc_type.charger, data)
		#return
	print(input_type.selected)
	match(input_type.selected):
		InputMode.KEYBOARD:
			mode = KEYBOARD_CONTROLS
		InputMode.CONTROLLER:
			mode = GAMEPAD_CONTROLS
	data.set("InputMode", mode)
	#z.add_character(data)
