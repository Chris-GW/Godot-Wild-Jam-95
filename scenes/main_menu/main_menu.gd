extends PanelContainer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		GameEvents.emit_game_started()

	if Input.is_action_just_pressed("toggle_credits"):
		GameEvents.emit_credits_screen_requested()
