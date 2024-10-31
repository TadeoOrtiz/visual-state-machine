extends State

var input: StateInput = StateInput.new(2, Color.AQUA)

func _init() -> void:
	input.method = a
	inputs.append(input)

func a():
	pass

func _on_enter() -> void:
	print(target)
	print("ASD")
