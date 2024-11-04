extends PlayerState

func _init() -> void:
	outputs.append(on_air)

func _on_enter() -> void:
	pass

func _input(event):
	jump.emit()
