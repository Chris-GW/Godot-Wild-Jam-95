extends TextureRect

@onready var cursor_button: Control = $".."


func _ready() -> void:
	cursor_button.focus_entered.connect(_on_button_focuse_changed)
	cursor_button.focus_exited.connect(_on_button_focuse_changed)
	_on_button_focuse_changed()


func _on_button_focuse_changed() -> void:
	self.visible = cursor_button.has_focus()
