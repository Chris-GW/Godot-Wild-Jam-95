@tool
class_name TextPanel
extends PanelContainer

const LINE_HEIGHT := 18.0
const TWEEN_SCROLL_DURATION := 0.1

@export_range(1, 3)
var max_lines := 3:
	set(value):
		max_lines = value

		_refresh_for_max_lines()

@export_multiline
var text: String = "<text>":
	set(value):
		text = value

		_refresh()

@onready
var scroll_container: ScrollContainer = %ScrollContainer

@onready
var label: Label = %Label

var _line_count := 0

func _refresh_for_max_lines() -> void:
	if scroll_container:
		scroll_container.custom_minimum_size.y = max_lines * LINE_HEIGHT

func _refresh() -> void:
	_line_count = text.count("\n") + 1

	if text.length() <= 0:
		_line_count = 0

	if scroll_container:
		var overflow_count := _line_count - max_lines
		var new_scroll := int(LINE_HEIGHT) * overflow_count

		if new_scroll != scroll_container.scroll_vertical:
			_tween_scroll(new_scroll)

	if label:
		label.text = text

func _tween_scroll(new_scroll: int) -> void:
	var tween := create_tween()

	tween.tween_property(
		scroll_container,
		"scroll_vertical",
		new_scroll,
		TWEEN_SCROLL_DURATION)

func clear_lines() -> void:
	text = ""

func add_line(line: String) -> void:
	if _line_count > 0:
		text += "\n" + line
	else:
		text = line
