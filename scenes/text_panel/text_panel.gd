@tool
class_name TextPanel
extends PanelContainer

const LABEL_SCENE := preload("uid://ny0ax1n8xdbi")

const LINE_HEIGHT := 18.0
const TWEEN_SCROLL_DURATION := 0.1

@export_range(1, 3)
var max_lines := 3:
	set(value):
		max_lines = value

		_refresh_for_max_lines()

@export_multiline
var lines: Array[String] = ["<text>"]:
	set(value):
		lines = value

		_refresh()

@onready
var scroll_container: ScrollContainer = %ScrollContainer

@onready
var labels_container: VBoxContainer = %LabelsContainer

func _refresh_for_max_lines() -> void:
	if scroll_container:
		scroll_container.custom_minimum_size.y = max_lines * LINE_HEIGHT

func _refresh() -> void:
	var line_count := lines.size()

	if scroll_container:
		var overflow_count := line_count - max_lines
		var new_scroll := int(LINE_HEIGHT) * overflow_count

		if new_scroll != scroll_container.scroll_vertical:
			_tween_scroll(new_scroll)

	_ensure_enough_labels(line_count)

	for i in labels_container.get_child_count():
		var label: Label = labels_container.get_child(i)
		if line_count > i:
			# TODO: if this is the line that was just added, tween the visible
			# characters ratio from 0 to 1...
			label.show()
			label.text = lines[i]
		else:
			label.hide()
			label.text = ""

func _ensure_enough_labels(line_count: int) -> void:
	while labels_container.get_child_count() < line_count:
		var new_label := LABEL_SCENE.instantiate()
		new_label.name = "Label%d" % labels_container.get_child_count()

		assert(new_label != null)
		labels_container.add_child(new_label)
		new_label.owner = labels_container

func _tween_scroll(new_scroll: int) -> void:
	var tween := create_tween()

	tween.tween_property(
		scroll_container,
		"scroll_vertical",
		new_scroll,
		TWEEN_SCROLL_DURATION)

func clear_lines() -> void:
	lines.clear()
	_refresh()

func add_line(line: String) -> void:
	lines.append(line)
	_refresh()
