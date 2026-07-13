class_name ListMenuInteraction
extends Node

var _selected_index_tracker := IndexTracker.new(0, "SelectedIndex")

signal index_changed(index: int)

func set_tracker_name(tracker_name: String) -> void:
	_selected_index_tracker.set_name(tracker_name)

func check() -> void:
	if Input.is_action_just_pressed("move_up"):
		var new_index := _selected_index_tracker.previous()
		index_changed.emit(new_index)

	if Input.is_action_just_pressed("move_down"):
		var new_index := _selected_index_tracker.next()
		index_changed.emit(new_index)

func current() -> int:
	return _selected_index_tracker.current()

func set_maximum(maximum: int) -> void:
	_selected_index_tracker.set_maximum(maximum)
