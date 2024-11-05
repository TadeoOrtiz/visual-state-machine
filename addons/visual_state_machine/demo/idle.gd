extends PlayerState

func _init() -> void:
	outputs.append(on_air)
	outputs.append(dash)
	outputs.append(walk)
	outputs.append(jump)
	outputs.append(death)

func _on_enter() -> void:
	print("HOLA IDLE")

func _input(event):
	print(event)
