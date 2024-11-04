@icon("res://addons/visual_state_machine/icons/state_machine.svg")
@tool
class_name StateMachine extends Node

const NOTIFICATION_STATE_EXIT: int = 11

signal states_changed
signal started
signal finished

@export var target: Node
@export var auto_start: bool
@export var scripts_states: Array[Script] = []:
	set(value):
		scripts_states = value

var _connections: Array[Dictionary]
var _nodes_position: Dictionary

var states_list: Array[State]
var current_state: State

func _enter_tree() -> void:
	create_states_objects()
	if _connections.size() > 0:
		_create_connections()

func _ready() -> void:
	if Engine.is_editor_hint(): return
	current_state = states_list[0]
	if auto_start: start()

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	if not current_state: return
	current_state._physics_process(delta)

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	if not current_state: return
	current_state._process(delta)

func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): return
	if not current_state: return
	current_state._input(event)

func _create_start_end_states() -> void:
	var start_state: State = State.new()
	start_state.set_name("Start")
	var start_output := StateOutput.new()
	start_output.display_name = "Start"
	start_state.outputs.append(start_output)
	
	
	var end_state: State = State.new()
	end_state.set_name("End")
	var end_input := StateInput.new(0)
	end_input.method = _end
	end_state.inputs.append(end_input)
	
	states_list.append(start_state)
	states_list.append(end_state)

func _create_connections() -> void:
	for i in _connections:
		var from_state = i["from_state"]
		var output_index = i["from_output"]
		var to_state = i["to_state"]
		var input_index = i["to_input"]
		
		var origin_state: State = find_state(from_state)
		var target_state: State = find_state(to_state)
		var output: StateOutput = origin_state.outputs[output_index]
		
		if output.output_called.is_connected(transition_to):
			output.output_called.disconnect(transition_to)
		output.connection = target_state.inputs[input_index]
		if target_state.get_name() != "End":
			output.output_called.connect(transition_to.bind(output.connection.method.get_object()))

func _end() -> void:
	current_state.notification(NOTIFICATION_STATE_EXIT)
	current_state = null
	finished.emit()

func start() -> void:
	started.emit()
	current_state.outputs[0].emit()

func transition_to(state: State) -> void:
	if state:
		current_state.notification(NOTIFICATION_STATE_EXIT)
		current_state = state
		states_changed.emit()

func create_states_objects() -> void:
	states_list.clear()
	
	_create_start_end_states()
	
	for script: Script in scripts_states:
		var state = script.new() as State
		if state:
			state.target = target
			
			var input := StateInput.new(0)
			input.method = state._on_enter
			state.inputs.push_front(input)
			states_list.append(state)
			
			state.set_name(script.resource_path.get_file().get_basename().capitalize())

func clear_connections() -> void:
	for connection in _connections:
		var state: State = find_state(connection[0])
		state.outputs[connection[1]].output_called.disconnect(transition_to)
		state.outputs[connection[1]].connection = null
	
	_connections.clear()

func connect_states(from_state: State, output_index: int, to_state: State, input_index: int) -> void:
	var output: StateOutput = from_state.outputs[output_index]

	output.connection = to_state.inputs[input_index]
	output.output_called.connect(transition_to.bind(output.connection.method.get_object()))
	
	
	var connection: Dictionary
	
	connection["from_state"] = from_state.get_name()
	connection["from_output"] = output_index
	connection["to_state"] = to_state.get_name()
	connection["to_input"] = input_index
	
	_connections.append(connection)

func disconnect_states(from_state: State, output_index: int, to_state: State, input_index: int) -> void:
	var output := from_state.outputs[output_index]
	output.output_called.disconnect(transition_to)
	output.connection = null
	
	var delete_connection: Dictionary
	
	delete_connection["from_state"] = from_state.get_name()
	delete_connection["from_output"] = output_index
	delete_connection["to_state"] = to_state.get_name()
	delete_connection["to_input"] = input_index
	
	for connection in _connections:
		if connection == delete_connection:
			_connections.erase(connection)

func find_state(state_name: String) -> State:
	for state in states_list:
		if state.get_name() == state_name:
			return state
	return null

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
