extends PlayerState

var death_end: StateOutput = StateOutput.new()

func _init() -> void:
	outputs.append(death_end)

func _on_enter() -> void:
	pass

func _input(event):
	jump.emit()
