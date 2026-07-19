class_name EnemyEntity
extends Area2D

@onready var navigation_timer: Timer = $NavigationTimer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var navigation_agent: NavigationAgent2D = $Sprite2D/NavigationAgent2D

@export
var encounter: Encounter

@export var move_speed: float
@export var move_speed_increase := 2.0
@export var catch_distance: float

## The dialogue resource
@export var dialogue_resource: DialogueResource
## Start from a given title when using balloon as a [Node] in a scene.
@export var start_from_title: String = ""

var _player: Player = null

signal defeated

func _ready() -> void:
	if encounter and EncounterProgress.is_complete(encounter):
		CustomLogger.debug("%s encounter is already completed, freeing %s..." % [start_from_title, name])
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	_player = body
	navigation_timer.start()
	_on_navigation_timer_timeout()
	set_monitoring.call_deferred(false)
	GameEvents.emit_enemy_chasing(self)

	var tween := create_tween()
	tween.set_loops()
	tween.tween_property(sprite_2d, "self_modulate", Color.RED, 0.3)
	tween.chain().tween_property(sprite_2d, "self_modulate", Color.WHITE, 0.3)


func _physics_process(delta: float) -> void:
	if not is_instance_valid(_player):
		navigation_timer.stop()
		return
	if _is_near_player():
		_start_battle()
	else:
		move_speed += move_speed_increase * delta
		_navigate_process(delta)


func _is_near_player() -> bool:
	var my_position := sprite_2d.global_position
	var distance := my_position.distance_to(_player.global_position)
	return distance < catch_distance


func _start_battle() -> void:
	_player = null
	DialogueManager.show_dialogue_balloon(dialogue_resource, start_from_title)
	await DialogueManager.dialogue_ended

	if encounter:
		SignalHelper.once(encounter.enemy_defeated, _on_encounter_enemy_defeated)
		BattleManager.start_encounter(encounter)

func _navigate_process(delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	var next_path_position := navigation_agent.get_next_path_position()
	var weight := 1.0 - exp(-move_speed * delta)
	sprite_2d.global_position = sprite_2d.global_position.move_toward(next_path_position, weight)
	#sprite_2d.look_at(next_path_position) # lets just flip the sprite
	var move_direction := sprite_2d.global_position.direction_to(next_path_position)
	if abs(move_direction.x) > abs(move_direction.y):
		sprite_2d.flip_h = move_direction.x < 0.0


func _on_navigation_timer_timeout() -> void:
	if is_instance_valid(_player):
		navigation_agent.target_position = _player.global_position

func _on_encounter_enemy_defeated() -> void:
	defeated.emit()
	EncounterProgress.complete(encounter)
	queue_free()
