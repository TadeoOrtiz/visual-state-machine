@tool
class_name EditorStateMachine extends Control

var current_state_machine: StateMachine

@onready var graph_edit: StateMachineGraphEdit = %GraphEdit
@onready var background: Panel = %Background
@onready var work_space: HSplitContainer = %WorkSpace
@onready var state_visualizer: ItemList = %StateVisualizer

func _ready() -> void:
	auto_translate_mode = AUTO_TRANSLATE_MODE_DISABLED

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if typeof(data) == TYPE_DICTIONARY:
		if data["type"] == "files":
			var count: int = data["files"].size()
			var i: int
			for file_path in data["files"]:
				var r = load(file_path)
				if r is StateResource:
					i += 1
			if i == count: return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var i: int
	for file_path in data["files"]:
		var state = load(file_path)
		if state is StateResource and state not in current_state_machine.states:
			i += 1
			
			state_visualizer.add_item(state.resource_path.get_file())
			graph_edit.add_node(at_position, state)

func show_data(state_machine: StateMachine) -> void:
	
	current_state_machine = state_machine
	graph_edit.state_machine = state_machine
	
	background.visible = false
	work_space.visible = true
	
	for state in state_machine.states:
		state_visualizer.add_item(state.resource_path.get_file())
		var pos: Vector2 = Vector2.ZERO
		if state_machine._nodes_position.has(state.resource_path.get_file().get_basename().capitalize()):
			pos = state_machine._nodes_position[state.resource_path.get_file().get_basename().capitalize()]
		graph_edit.add_node(pos, state)
	
	
	for connection in state_machine._connections:
		var from_node: String = connection[0].resource_path.get_file().get_basename().capitalize()
		var from_port: int = connection[1]
		var to_node: String = connection[2].resource_path.get_file().get_basename().capitalize()
		var to_port: int = connection[3]
		graph_edit.connect_node(from_node, from_port, to_node, to_port)

func clear() -> void:
	for node: Control in graph_edit.get_children():
		if node is StateGraphNode:
			node.queue_free()
	
	state_visualizer.clear()
	graph_edit.clear_connections()

func show_connections_in_sm() -> void:
	print(current_state_machine._connections)
	print(graph_edit.get_connection_list())

func refresh() -> void:
	#for state in current_state_machine.states:
		#state.refresh()
	
	current_state_machine.start()

func _on_graph_edit_end_node_move() -> void:
	for node: Control in graph_edit.get_children():
		if node is StateGraphNode:
			current_state_machine._nodes_position[node.state.resource_path.get_file().get_basename().capitalize()] = node.position
