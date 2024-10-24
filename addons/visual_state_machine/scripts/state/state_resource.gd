@tool
class_name StateResource extends Resource

signal refreshed

@export var state_script: Script = null:
	set(value):
		if _check_state(value):
			state_script = value
		else:
			exports.clear()
			transitions.clear()
			entries.clear()
			state_script = null

var exports: Array[ExportStateProperty]
var entries: Array[StateEntry]
var transitions: Array[StateTransition]

var state: State

func _init() -> void:
	_check_state(state_script)

func refresh() -> void:
	if _check_state(state_script):
		refreshed.emit()

func _check_state(script: Script) -> bool:
	if script == null: return false
	
	state = script.new()
	if state is not State:
		push_error("Script " + script.resource_path + " not extend State class")
		state = null
		return false
	
	_set_state_data()
	return true

func _set_state_data() -> void:
	exports.clear()
	transitions.clear()
	entries.clear()
	
	state._init_state()
	
	for transition_event in state._get_transition_events():
		transitions.append(transition_event)
	
	entries.append(StateEntry.new(0, state._on_enter))
	for entry_event in state._get_entry_events():
		entries.append(entry_event)
	
	for state_propertie in state.get_property_list():
		if state_propertie["usage"] & PROPERTY_USAGE_STORAGE == PROPERTY_USAGE_STORAGE \
		and state_propertie["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE == PROPERTY_USAGE_SCRIPT_VARIABLE:
			var p_name: String = state_propertie["name"]
			var p_type: int = state_propertie["type"]
			var p_value: Variant = state.get(p_name)
			var export_property: ExportStateProperty = ExportStateProperty.new(p_name, p_type, p_value)
			exports.append(export_property)

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary]
	
	properties.append(
		{
			"name": "exports",
			"type": TYPE_ARRAY,
			"usage": PROPERTY_USAGE_STORAGE
		}
	)
	
	properties.append(
		{
			"name": "entries",
			"type": TYPE_DICTIONARY,
			"usage": PROPERTY_USAGE_STORAGE
		}
	)
	
	properties.append(
		{
			"name": "transitions",
			"type": TYPE_DICTIONARY,
			"usage": PROPERTY_USAGE_STORAGE
		}
	)
	
	return properties
