extends BaseMap

const PLAYER_WAKEUP = preload("uid://v5wtcuq2uy1r")
const FIRST_CONSOLE_INTERACTION = preload("uid://cqvucqik7hiof")

@onready var exit_player_home_left: Area2D = %ExitPlayerHomeLeft
@onready var exit_player_home_right: Area2D = %ExitPlayerHomeRight
@onready var pc_interaction_area_2d: Area2D = $MapTransitionAreas/PcInteractionArea2D
@onready var locked_doors: StaticBody2D = $MapTransitionAreas/LockedDoors


func _ready() -> void:
	super._ready()
	if PlayerManager.first_wakeup:
		_setup_first_wakeup()


func _setup_first_wakeup() -> void:
	PlayerManager.first_wakeup = false
	exit_player_home_left.monitoring = false
	exit_player_home_right.monitoring = false
	locked_doors.process_mode = Node.PROCESS_MODE_INHERIT
	DialogueManager.show_dialogue_balloon.call_deferred(PLAYER_WAKEUP)
	SignalHelper.once(
		pc_interaction_area_2d.body_entered, 
		_on_pc_interaction_area_2d_body_entered)


func _on_pc_interaction_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		DialogueManager.show_dialogue_balloon.call_deferred(FIRST_CONSOLE_INTERACTION)
		exit_player_home_left.monitoring = true
		exit_player_home_right.monitoring = true
		locked_doors.process_mode = Node.PROCESS_MODE_DISABLED
