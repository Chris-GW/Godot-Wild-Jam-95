extends Node

var _player: PlayerBattler = preload("res://resources/players/player_default.tres")
var prologue_wakeup := true
var prologue_has_game := false
var prologue_pc_interaction_count := 0


func _ready() -> void:
	if OS.is_debug_build():
		prologue_wakeup = false
		prologue_has_game = true

func get_current() -> PlayerBattler:
	return _player


func increase_prologue_pc_interaction_count() -> void:
	prologue_pc_interaction_count = mini(prologue_pc_interaction_count + 1, 3)
