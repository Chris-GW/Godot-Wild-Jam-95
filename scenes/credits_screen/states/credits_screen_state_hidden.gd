class_name CreditsScreenStateHidden
extends CreditsScreenState

func _enter_tree() -> void:
	CustomLogger.debug("%s is now hidden" % _credits_screen.name)

	_appearance.for_hidden()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_credits"):
		transition_state(CreditsScreen.State.SHOWN)
