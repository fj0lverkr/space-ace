extends Node

# BGM
enum Loop {MERCURY, TITLE}

const BGM: Dictionary = {
	Loop.MERCURY: preload("res://assets/sounds/loops/Mercury.wav"),
	Loop.TITLE: preload("res://assets/sounds/loops/TitleScreen.mp3"),
}

# MISC
const MISC_DOOR: AudioStream = preload("res://assets/sounds/misc/sci-fi-door.wav")

# POWERUP
const PU_DEPLOY: AudioStream = preload("res://assets/sounds/powerup/power_up_deploy.wav")
const PU_SFX: Dictionary = {
	PowerUp.Type.SHIELD: preload("res://assets/sounds/powerup/shield_18.wav"),
	PowerUp.Type.POWERUP: preload("res://assets/sounds/powerup/health_16.wav"),
}

# LASERS + EXPLOSIONS
enum SoundType {LASER, EXPLOSION}

const SOUNDS_PATH: Dictionary = {
	SoundType.LASER: "res://assets/sounds/lasers/",
	SoundType.EXPLOSION: "res://assets/sounds/explosions/",
}

var _lasers: Array = []
var _explosions: Array = []

var _sound_data: Dictionary = {
	SoundType.LASER: _lasers,
	SoundType.EXPLOSION: _explosions,
}


func _ready() -> void:
	for t: SoundType in SoundType.values():
		_load_by_type(t)


func _load_by_type(type: SoundType) -> void:
	if not SOUNDS_PATH.has(type):
		return

	if not _sound_data.has(type):
		return

	var path: String = SOUNDS_PATH[type]
	var dir: DirAccess = DirAccess.open(path)
	if not dir:
		return
	
	var sfiles: Array[String]
	var files: PackedStringArray = dir.get_files()
	sfiles.assign(files)
	sfiles = sfiles.filter(_filter_files)
	if sfiles.size() == 0:
		return

	for i: int in range(sfiles.size()):
		var prefix: String = "sfx_wpn_laser" if type == SoundType.LASER else "sfx_exp_medium"
		var p: String = "%s%s%s.wav" % [path, prefix, str(i + 1)]
		var f: AudioStream = load(p)

		_sound_data[type].append(f)


func _filter_files(e: String) -> bool:
	return !e.ends_with(".import")


func play_bgm(player: AudioStreamPlayer, which: Loop) -> void:
	if not BGM.has(which):
		return

	player.stream = BGM[which]
	player.play()


func play_pu_deploy(player: AudioStreamPlayer2D) -> void:
	player.stream = PU_DEPLOY
	player.play()


func play_pu_activate(player: AudioStreamPlayer2D, which: PowerUp.Type) -> void:
	if not PU_SFX.has(which):
		return

	player.stream = PU_SFX[which]
	player.play()


func play_by_type(player: AudioStreamPlayer2D, type: SoundType, index: int = -1) -> void:
	if not _sound_data.has(type):
		return

	if index > -1 and _sound_data[type].size() > index:
		player.stream = _sound_data[type][index]
	else:
		player.stream = _sound_data[type].pick_random()
	player.play()