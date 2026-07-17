class_name CreditsScreenStateShown
extends CreditsScreenState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now shown" % _credits_screen.name)

	_appearance.for_shown()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_credits"):
		transition_state(CreditsScreen.State.HIDDEN)

	if Input.is_action_just_pressed("move_right"):
		_appearance.next_tab()

	if Input.is_action_just_pressed("move_left"):
		_appearance.previous_tab()

	if _appearance.can_scroll():
		var scroll_amount := Input.get_axis("move_up", "move_down")
		_appearance.scroll_by(scroll_amount)

func is_shown() -> bool:
	return true
