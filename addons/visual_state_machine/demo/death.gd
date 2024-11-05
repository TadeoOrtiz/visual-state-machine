extends PlayerState

var death_end: StateOutput = StateOutput.new()

func _init() -> void:
	outputs.append(death_end)

func _on_enter() -> void:
	death_end.emit()

func _input(event):
	jump.emit()
