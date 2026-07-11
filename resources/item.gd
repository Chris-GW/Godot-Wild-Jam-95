@tool
class_name Item
extends Resource

@export
var id := -1:
	set(value):
		id = value

		emit_changed()

@export
var name := "<item>":
	set(value):
		name = value

		emit_changed()

@export_multiline
var description := "<description>":
	set(value):
		description = value

		emit_changed()
