extends BaseMap

@onready var exit_player_home: Interactable = %ExitPlayerHome
@onready var crt_tv: EnemyEntity = %CrtTv
@onready var dial_pad_phone: EnemyEntity = %DialPadPhone

@export var mp3_player_encounter: Encounter


func _ready() -> void:
	super._ready()
	
	var complete_crt_tv := EncounterProgress.is_complete(crt_tv.encounter)
	var complete_dial_pad_phone := EncounterProgress.is_complete(dial_pad_phone.encounter)
	var complete_mp3_player_encounter := EncounterProgress.is_complete(mp3_player_encounter)
	
	if complete_crt_tv:
		crt_tv.queue_free()
	else:
		_enable_enemy(crt_tv)
	
	if complete_dial_pad_phone:
		dial_pad_phone.queue_free()
	elif complete_mp3_player_encounter:
		_enable_enemy(dial_pad_phone)


func _enable_enemy(enemy: EnemyEntity) -> void:
	enemy.monitoring = true
	CustomLogger.info("Enable encounter with enemy %s" % enemy.name)
