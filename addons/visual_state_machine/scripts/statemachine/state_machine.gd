@tool
class_name StateMachine extends Node

signal states_changed

@export var auto_start: bool
@export var states: Array[StateResource] = []:
	set(value):
		states = value
		states_changed.emit()

var _connections: Array[Array]
var _nodes_position: Dictionary

func _ready() -> void:
	if auto_start: start()

func start() -> void:
	states[0]._set_state_data()
	states[0].state._on_enter()

func connect_states(from_state: StateResource, transition_index: int, to_state: StateResource, entry_index: int) -> void:
	var transition := from_state.transitions[transition_index]
	transition.connect_entry(to_state.entries[entry_index])
	
	_connections.append([from_state, transition_index, to_state, entry_index])

func disconnect_states(from_state: StateResource, transition_index: int, to_state: StateResource, entry_index: int) -> void:
	var transition := from_state.transitions[transition_index]
	transition.disconnect_entry(to_state.entries[entry_index])
	
	_connections.erase([from_state, transition_index, to_state, entry_index])

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary]
	
	properties.append(
		{
			"name": "_connections",
			"type": TYPE_ARRAY,
			"usage": PROPERTY_USAGE_STORAGE
		}
	)
	
	properties.append(
		{
			"name": "_nodes_position",
			"type": TYPE_DICTIONARY,
			"usage": PROPERTY_USAGE_STORAGE
		}
	)
	
	return properties
