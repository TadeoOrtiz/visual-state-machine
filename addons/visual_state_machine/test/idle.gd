extends State

var output: StateOutput = StateOutput.new(2, Color.AQUA)
var output2: StateOutput = StateOutput.new()

func _init() -> void:
	output = StateOutput.new(2, Color.AQUA)
	outputs.append(output)
	outputs.append(output2)

func _on_enter() -> void:
	output2.emit()
