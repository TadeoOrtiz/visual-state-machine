class_name StateInput extends RefCounted
## @experimental
## Input object for a state
##
## This class allows to create inputs for the states, 
## they must be added later in [method State._init] of the state.
##
## 
## [codeblock]
## var input = StateInput.new(2, Color.AQUA)
## var other_input = StateInput.new(MyEnum.Second, Color(0.5, 0.5, 0.5))
##
## func _init() -> void:
##     input.method = method
##     other_input.method = other_method
##     inputs.append(input)
##     inputs.append(other_input) 
## 
## func method():
##    pass
##
## func other_method():
##    pass
##[/codeblock]

func _init(_tpye: int = 0, _color: Color = Color.WHITE) -> void:
	type = _tpye
	color = _color

## Define the type of output
var type: int

## Color of port in graph
var color: Color

## Linked method
var method: Callable
