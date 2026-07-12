class_name BaseMap
extends Node2D

@onready var player_spawn: Marker2D = %PlayerSpawn
@onready var y_sort: Node2D = $YSort


func _ready() -> void:
	$Parallax2D.show() # show infinte water only while running the game
	%WorldNameLabel.text = self.scene_file_path.get_file().get_basename()
	%WorldNameLabel.visible = OS.is_debug_build()
