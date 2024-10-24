extends State

var idle := StateTransition.new(1, "Idle")

func _on_enter() -> void:
	print("walk")

func _get_transition_events():
	return [idle]
