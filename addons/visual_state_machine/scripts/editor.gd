@tool
class_name EditorStateMachine extends Control

var current_state_machine: StateMachine

@onready var graph_edit: StateMachineGraphEdit = %GraphEdit

func _ready() -> void:
	auto_translate_mode = AUTO_TRANSLATE_MODE_DISABLED

func show_data(state_machine: StateMachine) -> void:
	if state_machine == current_state_machine: return
	current_state_machine = state_machine
	graph_edit.state_machine = state_machine
	
	graph_edit.remove_node()
	create_nodes()
	
	for connection in current_state_machine._connections:
		graph_edit.connect_node(connection[0], connection[1], connection[2], connection[3])
	

func create_nodes() -> void:
	for state: State in current_state_machine.states_list:
		var pos := Vector2.ZERO
		if current_state_machine._nodes_position.has(state.get_name()):
			pos = current_state_machine._nodes_position[state.get_name()]
		graph_edit.add_node(pos, state)

func show_connections_in_sm() -> void:
	print(current_state_machine._connections)
	print(graph_edit.get_connection_list())
	print(graph_edit.get_children())

func refresh() -> void:
	current_state_machine.create_states_objects()
	
	var i: int
	for node: Control in graph_edit.get_children():
		if node is StateGraphNode:
			node.state = current_state_machine.states_list[i]
			node.refresh_graph()
			node.size.y = 0
			i += 1

func clear_nodes() -> void:
	graph_edit.remove_node()

func _on_graph_edit_end_node_move() -> void:
	for node: Control in graph_edit.get_children():
		if node is StateGraphNode:
			current_state_machine._nodes_position[node.state.get_name()] = node.position
