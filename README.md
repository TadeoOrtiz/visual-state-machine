<div align="center">
	<img src="icon.svg" alt="Logo" width="160" height="160">
<h3 align="center">Node Finite State Machine</h3>

</div>

A State Nachine whit visual nodes and connections for your game

![Pasted image 20241102164614](https://github.com/user-attachments/assets/05a3675a-c6db-46c5-b0fc-26518861b7c2)
## State Class Virtual Functions

```gdscript
class_name State extends RefCounted

var _name: String

## Target of state
var target: Node

## Inputs list linked to custom function
var inputs: Array[StateInput]

## Outputs list of the state
var outputs: Array[StateOutput]

## Called when State is created from a State Machine
func _init_state() -> void:
	pass

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
```

---

## Recipe to add a new State Machine

1. Add into your scene tree StateMachine Node
2. Create in State script in folder, this script that exteds from `State`
3. Create outputs into State
4. Put script in ScriptList of the StateMachine
5. Connect the outputs into another state input

## Create Inputs for your state

```gdscript
var input = StateInput.new(2, Color.AQUA)
var other_input = StateInput.new(MyEnum.Second, Color(0.5, 0.5, 0.5))

func _init() -> void:
    input.method = method
    other_input.method = other_method
    inputs.append(input)
    inputs.append(other_input) 

func method():
    pass

func other_method():
    pass
```

## Create outputs for your State

```gdscript
var output = StateOutput.new(2, Color.AQUA, "Return To Menu")
var other_output = StateOutput.new(MyEnum.Second, Color(0.5, 0.5, 0.5), output_name)

func _init() -> void:
    inputs.append(output)
    inputs.append(other_output) 
```

