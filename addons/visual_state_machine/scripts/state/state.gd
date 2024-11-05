class_name State extends RefCounted
## Abtract class for create states
##
## This class contains the methods and properties 
## necessary to create behavioral states for other nodes.
##

## Notification recived when the State exit in the State Machine
const NOTIFICATION_STATE_EXIT: int = 11

## Notification recived when State Machine attached to State is ready
const NOTIFICATION_STATEMACHINE_READY: int = 12

var _name: String

## Target of state
var target: Node

## Inputs list linked to custom function
var inputs: Array[StateInput]

## Outputs list of the state
var outputs: Array[StateOutput]

## Called when the State Machine is Ready
func _on_statemachine_ready() -> void:
	pass

## Called when [StateOutput] is connected
func _on_enter() -> void:
	pass

## Called when any [StateOutput] in state is emited
func _on_exit() -> void:
	pass

## This function executes on each frame of the finite state machine's process
func _process(delta: float) -> void:
	pass

## This function executes on each frame of the finite state machine's physic process
func _physics_process(delta: float) -> void:
	pass

## In case you want to customize how this state handle the 
## inputs in your game this is the place to do that.
func _input(event: InputEvent) -> void:
	pass

## Set state name
func set_name(n: String) -> void:
	_name = n

## Return state name
func get_name() -> String:
	return _name

func _to_string() -> String:
	return get_name()

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_STATE_EXIT:
			_on_exit()
		NOTIFICATION_STATEMACHINE_READY:
			_on_statemachine_ready()
