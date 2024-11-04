class_name StateGraphNode extends GraphNode

var state: State

func _init() -> void:
	custom_minimum_size.x = 150

func _enter_tree() -> void:
	create()

func create() -> void:
	create_entries()
	var properties_separator = HSeparator.new()
	add_child(properties_separator)
	create_outputs()

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

func create_outputs():
	for output: StateOutput in state.outputs:
		var output_label: Label = Label.new()
		output_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		output_label.text = output.display_name
		add_child(output_label)
		var index: int = output_label.get_index()
		set_slot_enabled_right(index, true)
		set_slot_type_right(index, output.type)
		set_slot_color_right(index, output.color)
