extends Node

var _completed_titles: Array[String] = []

func complete(title: String) -> void:
	if not _completed_titles.has(title):
		_completed_titles.append(title)

func is_complete(title: String) -> bool:
	return _completed_titles.has(title)
