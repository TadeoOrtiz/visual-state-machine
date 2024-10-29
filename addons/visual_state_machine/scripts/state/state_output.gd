class_name StateOutput extends RefCounted

signal output_called

func _init(_type: int = 0, _color: Color = Color.WHITE) -> void:
	type = _type
	color = _color

var type: int
var name: String
var color: Color
var connection: StateInput = null

func emit() -> void:
	if connection:
		print("---")
		print(output_called)
		output_called.emit()
		connection.method.call()
	else:
		printerr("%s output is not connected" % [name])
