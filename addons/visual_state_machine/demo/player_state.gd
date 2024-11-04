class_name PlayerState extends State

var jump: StateOutput = StateOutput.new(1, Color.WHITE, "Jump")
var walk: StateOutput = StateOutput.new(1, Color.WHITE, "Walk")
var dash: StateOutput = StateOutput.new(1, Color.WHITE, "Dash")
var death: StateOutput = StateOutput.new(1, Color.WHITE, "Death")
var on_air: StateOutput = StateOutput.new(1, Color.WHITE, "On Air")

func _init() -> void:
	inputs.append(death)
