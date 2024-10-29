@tool
class_name StateMachineGraphEdit extends GraphEdit

var state_machine: StateMachine

func _ready() -> void:
	add_valid_right_disconnect_type(0)
	

func add_node(at_position: Vector2, state: State) -> void:
	var state_node = StateGraphNode.new()
	state_node.position_offset = at_position
	state_node.state = state
	
	for t in state.outputs:
		if not is_valid_connection_type(t.type, 0):
			add_valid_connection_type(t.type, 0)
			add_valid_right_disconnect_type(t.type)
	
	state_node.name = state.get_name()
	
	add_child(state_node, true)
	state_node.title = state_node.name

func remove_node() -> void:
	clear_connections()
	for child in get_children():
		if child is StateGraphNode:
			child.queue_free()

func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	var origin_node: StateGraphNode = get_node(NodePath(from_node)) as StateGraphNode
	var target_node: StateGraphNode = get_node(NodePath(to_node)) as StateGraphNode
	
	for i in target_node.state.inputs.size():
		if is_node_connected(from_node, from_port, to_node, i):
			disconnect_node(from_node, from_port, to_node, i)
			connect_node(from_node, from_port, to_node, to_port)
			print("reconecion")
			return
	
	state_machine.connect_states(origin_node.state, from_port, target_node.state, to_port)
	connect_node(from_node, from_port, to_node, to_port)


func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	var origin_node: StateGraphNode = get_node(NodePath(from_node)) as StateGraphNode
	var target_node: StateGraphNode = get_node(NodePath(to_node)) as StateGraphNode
	
	state_machine.disconnect_states(origin_node.state, from_port, target_node.state, to_port)
	disconnect_node(from_node, from_port, to_node, to_port)
