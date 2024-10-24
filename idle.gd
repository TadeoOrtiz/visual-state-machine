extends State

var walk: StateTransition

func _init_state() -> void:
	walk = StateTransition.new(1, "Walk")

func _on_enter() -> void:
	print("idle")
	print(is_instance_valid(walk))
	print(walk.connections)
	walk.emit()

func _get_transition_events():
	return [walk]
