@tool
extends EditorPlugin

signal state_script_saved

const EditorScene = preload("res://addons/visual_state_machine/editor.tscn")
const StateMachineScene = preload("res://addons/visual_state_machine/scripts/statemachine/state_machine.gd")

var editor: EditorStateMachine

func _enter_tree() -> void:
	editor = EditorScene.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(editor)
	
	add_custom_type(
		"StateMachine",
		"Node",
		StateMachineScene,
		null
	)
	_make_visible(false)
	editor.hide()

func _has_main_screen():
	return true

func _make_visible(visible):
	if is_instance_valid(editor):
		if !editor.current_state_machine:
			editor.visible = false
			return
		editor.visible = visible

func _get_plugin_name() -> String:
	return 'Visual StateMachine'

func _get_plugin_icon() -> Texture2D:
	return load("res://addons/visual_state_machine/icons/state_machine.svg")

func _handles(object: Object) -> bool:
	return object is StateMachine

func _edit(object: Object) -> void:
	if is_instance_valid(editor):
		if object is StateMachine:
			editor.visible = true
			editor.show_data(object)
		else:
			_make_visible(false)
			editor.current_state_machine = null
			editor.clear_nodes()

func _exit_tree() -> void:
	remove_custom_type("StateMachine")
	editor.queue_free()
