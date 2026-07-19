extends Node

var _player: PlayerBattler = preload("res://resources/players/player_default.tres")


# global vars for dialouge 
var prologue_wakeup := true
var prologue_has_game := false
var prologue_pc_interaction_count := 0
var is_back_home := false


func get_current() -> PlayerBattler:
	return _player


func increase_prologue_pc_interaction_count() -> void:
	prologue_pc_interaction_count = mini(prologue_pc_interaction_count + 1, 3)
