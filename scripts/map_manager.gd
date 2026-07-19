class_name WorldMapManager
extends Node2D

@export_group("Debug")

@export_file("*.tscn")
var maps: Array[String] = []

@onready var current_map: BaseMap = $CurrentMap

var _current_map_path := ""
var _current_map_enter_node_name := ""

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN # hide mouse
	GameEvents.map_transition_requested.connect(_on_map_transition_requested)
	DialogueManager.get_current_scene = func():
		return current_map

	SignalHelper.persist(GameEvents.player_defeated, _reload_map)

	set_process(OS.has_feature("editor_runtime"))

func _process(_delta: float) -> void:
	for i in maps.size():
		if Input.is_action_just_pressed("debug_load_map_%d" % i):
			_load_map(maps[i], "")

func transition_map_to(map: BaseMap, enter_node_name: String = "") -> void:
	remove_child(current_map)
	current_map.queue_free()
	current_map = map
	assert(map != null)
	add_child(map)
	if not enter_node_name.is_empty():
		map.set_enter_node(enter_node_name)

func _on_map_transition_requested(map_scene_path: String, enter_node_name: String) -> void:
	_load_map(map_scene_path, enter_node_name)

func _reload_map() -> void:
	CustomLogger.info("Reloading map %s" % current_map.name)
	_load_map(_current_map_path, _current_map_enter_node_name)

func _load_map(map_scene_path: String, enter_node_name: String) -> void:
	_current_map_path = map_scene_path
	_current_map_enter_node_name = enter_node_name

	var map_resource := ResourceLoader.load(map_scene_path) as PackedScene
	var map := map_resource.instantiate() as BaseMap
	transition_map_to.call_deferred(map, enter_node_name)
