@icon("res://addons/visual_state_machine/icons/state_machine.svg")
@tool
class_name StateMachine extends Node

signal states_changed
signal started
signal finished

@export var target: Node
@export var auto_start: bool
@export var scripts_states: Array[Script] = []:
	set(value):
		scripts_states = value

var _connections: Array[Array]
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
	start_state._name = "Start"
	var start_output := StateOutput.new()
	start_output.name = "Start"
	start_state.outputs.append(start_output)
	
	
	var end_state: State = State.new()
	end_state._name = "End"
	var end_input := StateInput.new(0)
	end_input.method = _end
	end_state.inputs.append(end_input)
	
	states_list.append(start_state)
	states_list.append(end_state)

func _create_connections() -> void:
	for i in _connections:
		var from_state = i[0]
		var output_index = i[1]
		var to_state = i[2]
		var input_index = i[3]
		
		var origin_state: State = find_state(from_state)
		var target_state: State = find_state(to_state)
		var output: StateOutput = origin_state.outputs[output_index]
		
		if output.output_called.is_connected(transition_to):
			output.output_called.disconnect(transition_to)
		output.connection = target_state.inputs[input_index]
		if target_state.get_name() != "End":
			output.output_called.connect(transition_to.bind(output.connection.method.get_object()))

func _end() -> void:
	current_state = null
	finished.emit()

func start() -> void:
	started.emit()
	current_state.outputs[0].emit()

func transition_to(state: State) -> void:
	if state:
		current_state._on_exit()
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

func connect_states(from_state: State, output_index: int, to_state: State, input_index: int) -> void:
	var output: StateOutput = from_state.outputs[output_index]

	output.connection = to_state.inputs[input_index]
	output.output_called.connect(transition_to.bind(output.connection.method.get_object()))
	
	_connections.append([from_state.get_name(), output_index, to_state.get_name(), input_index])

func disconnect_states(from_state: State, output_index: int, to_state: State, input_index: int) -> void:
	var output := from_state.outputs[output_index]
	output.output_called.disconnect(transition_to)
	output.connection = null
	
	_connections.erase([from_state.get_name(), output_index, to_state.get_name(), input_index])

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
