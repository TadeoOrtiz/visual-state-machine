class_name StateTransition extends RefCounted

func _init(_type: int, _name: String, _color: Color = Color.WHITE) -> void:
	type = _type
	name = _name
	color = _color

@export var type: int
@export var name: String
@export var color: Color
var connections: Array[StateEntry]

func emit() -> void:
	for connection in connections:
		connection.entry_method.call()

func connect_entry(entry: StateEntry) -> void:
	connections.append(entry)

func disconnect_entry(entry: StateEntry) -> void:
	connections.erase(entry)

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary]
	
	properties.append(
		{
			"name": "connections",
			"type": TYPE_ARRAY,
			"usage": PROPERTY_USAGE_STORAGE
		}
	)
	
	return properties

func _to_string() -> String:
	return "type: %d - name: %s" % [type, name]
