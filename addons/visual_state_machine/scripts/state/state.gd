class_name State extends RefCounted

var _name: String

var target: Node
var inputs: Array[StateInput]
var outputs: Array[StateOutput]


func _on_enter() -> void:
	pass

func _on_exit() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

func _to_string() -> String:
	return get_name()

func get_name() -> String:
	if _name == "":
		return get_script().resource_path.get_file().get_basename().capitalize()
	return _name
