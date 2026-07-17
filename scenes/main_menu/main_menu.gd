extends PanelContainer

@onready
var credits_screen: CreditsScreen = %CreditsScreen

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("confirm"):
		if credits_screen and not credits_screen.is_shown():
			GameEvents.emit_game_started()
