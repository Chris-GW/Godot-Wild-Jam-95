extends BaseMap

@onready var world_teleporter: WorldTeleporter = %WorldTeleporter
@onready var discord_notification_sfx: AudioStreamPlayer = $DiscordNotificationSfx
@onready var crt_tv: EnemyEntity = %CrtTv
@onready var dial_pad_phone: EnemyEntity = %DialPadPhone
@onready var radio: Interactable = %Radio


func _ready() -> void:
	super._ready()
	
	_try_enable_enemy(crt_tv)
	_try_enable_enemy(dial_pad_phone)


func _try_enable_enemy(enemy: EnemyEntity) -> void:
	if enemy.is_queued_for_deletion():
		CustomLogger.info("Enemy %s entity is queued for deletion, ignoring" % enemy.name)
	elif EncounterProgress.is_available(enemy.encounter):
		enemy.monitoring = true
		CustomLogger.info("Enabled encounter with enemy %s" % enemy.name)
	else:
		CustomLogger.info("%s encounter is not yet available" % enemy.name)


func start_world_transformation() -> void:
	PlayerManager.is_back_home = true
	world_teleporter.start_world_transformation()
