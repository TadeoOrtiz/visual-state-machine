class_name StateGraphNode extends GraphNode

var state: State

func _init() -> void:
	resizable = true
	custom_minimum_size.x = 150

func _enter_tree() -> void:
	create()

func refresh_graph() -> void:
	clear()
	create()

func create() -> void:
	create_entries()
	var properties_separator = HSeparator.new()
	add_child(properties_separator)
	create_transitions()

func clear() -> void:
	for child in get_children():
		child.queue_free()

func create_entries():
	for input: StateInput in state.inputs:
		var enter_control: Label = Label.new()
		enter_control.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		enter_control.text = str(input.method.get_method())
		
		add_child(enter_control)
		
		var index: int = enter_control.get_index()
		set_slot_enabled_left(index, true)
		set_slot_type_left(index, input.type)
		set_slot_color_left(index, input.color)

func create_transitions():
	for transition: StateOutput in state.outputs:
		var transition_label: Label = Label.new()
		transition_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		transition_label.text = transition.name
		add_child(transition_label)
		var index: int = transition_label.get_index()
		set_slot_enabled_right(index, true)
		set_slot_type_right(index, transition.type)
		set_slot_color_right(index, transition.color)
