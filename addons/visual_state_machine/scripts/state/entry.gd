class_name StateEntry extends RefCounted

func _init(_tpye: int, _entry_method: Callable, _color: Color = Color.WHITE) -> void:
	type = _tpye
	entry_method = _entry_method
	color = _color

@export var type: int
@export var entry_method: Callable
@export var color: Color
