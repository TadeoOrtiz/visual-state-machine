extends PlayerState

var to_jump: StateInput = StateInput.new()
var to_idle: StateInput = StateInput.new()
var to_walk: StateInput = StateInput.new()
var to_dash: StateInput = StateInput.new()

func _init() -> void:
	to_jump.method = for_jump
	to_idle.method = for_idle
	to_walk.method = for_walk
	to_dash.method = for_dash
	
	inputs.append(to_idle)
	inputs.append(to_jump)
	
	outputs.append(death)

func for_idle() -> void:
	pass

func for_jump() -> void:
	pass

func for_walk() -> void:
	pass

func for_dash() -> void:
	pass
