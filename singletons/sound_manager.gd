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


func _ready() -> void:
	pass


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