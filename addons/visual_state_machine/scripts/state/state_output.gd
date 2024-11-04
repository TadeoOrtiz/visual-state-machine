class_name StateOutput extends RefCounted
## @experimental
## Output object for a state
##
## This class allows to create outputs for the states, 
## they must be added later in [method State._init] of the state.
##
## 
## [codeblock]
## var output = StateOutput.new(2, Color.AQUA, "Return To Menu")
## var other_output = StateOutput.new(MyEnum.Second, Color(0.5, 0.5, 0.5), output_name)
##
## func _init() -> void:
##     inputs.append(output)
##     inputs.append(other_output) 
## [/codeblock]


## Emited when [method emit] called
signal output_called

func _init(_type: int = 0, _color: Color = Color.WHITE, _display_name: String = "") -> void:
	type = _type
	color = _color
	display_name = _display_name

## Define the type of output
var type: int

## Name in graph
var display_name: String

## Color of port in graph
var color: Color

## The connection for output
var connection: StateInput

## Emit the [signal output_called] and call [member connection] method
func emit() -> void:
	if connection:
		output_called.emit()
		connection.method.call()
	else:
		printerr("%s output is not connected" % [display_name])
