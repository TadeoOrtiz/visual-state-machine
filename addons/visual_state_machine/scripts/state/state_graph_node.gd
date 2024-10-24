class_name StateGraphNode extends GraphNode

var state: StateResource

func _init() -> void:
	resizable = true
	custom_minimum_size.x = 150

func _ready() -> void:
	refresh_graph()

func refresh_graph() -> void:
	
	for child in get_children():
		clear_slot(child.get_index())
		child.queue_free()
	
	create_entries()
	create_transitions()
	var properties_separator = HSeparator.new()
	add_child(properties_separator)
	create_exports()
	

func create_entries():
	for entry: StateEntry in state.entries:
		var enter_control: Label = Label.new()
		enter_control.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		enter_control.text = str(entry.entry_method)
		
		add_child(enter_control)
		
		var index: int = enter_control.get_index()
		set_slot_enabled_left(index, true)
		set_slot_type_left(index, entry.type)
		set_slot_color_left(index, entry.color)

func create_transitions():
	for transition: StateTransition in state.transitions:
		var transition_label: Label = Label.new()
		transition_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		transition_label.text = transition.name
		add_child(transition_label)
		var index: int = transition_label.get_index()
		set_slot_enabled_right(index, true)
		set_slot_type_right(index, transition.type)
		set_slot_color_right(index, transition.color)

func create_exports():
	for property: ExportStateProperty in state.exports:
		var propertie_container: HBoxContainer = HBoxContainer.new()
		propertie_container.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		
		var properie_name: Label = Label.new()
		properie_name.text = property.name
		properie_name.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		add_child(propertie_container)
		propertie_container.add_child(properie_name)
		
		match(property.type):
			TYPE_INT:
				var b = Button.new()
				b.text = property.name
				propertie_container.add_child(b)
			TYPE_STRING:
				var b = Label.new()
				b.text = property.value
				propertie_container.add_child(b)
