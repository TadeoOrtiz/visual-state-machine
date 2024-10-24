class_name State extends RefCounted

var _state_machine: StateMachine

func _init_state() -> void:
	pass

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

func _get_transition_events() -> Array[StateTransition]:
	return []

func _get_entry_events() -> Array[StateEntry]:
	return []
