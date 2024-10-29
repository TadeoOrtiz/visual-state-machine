class_name StateInput extends RefCounted

func _init( _tpye: int = 0, _color: Color = Color.WHITE) -> void:
	type = _tpye
	color = _color

var type: int
var method: Callable
var color: Color
