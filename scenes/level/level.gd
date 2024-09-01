extends Node2D

@onready
var _pause_overlay: CanvasLayer = $Pause
@onready
var _bgm_player: AudioStreamPlayer = $BGM


func _ready() -> void:
	Engine.time_scale = 1
	SoundManager.play_bgm(_bgm_player, SoundManager.Loop.MERCURY)
	SignalBus.on_continue.connect(_toggle_pauze.bind(false))

	# for testing purposes
	#SignalBus.on_try_powerup.emit(100.0, PowerUp.Type.SHIELD, Vector2(100.0, 100.0))
	#SignalBus.on_explode.emit(Explosion.Type.EXPLOSION, Vector2(250.0, 250.0))


func _process(delta: float) -> void:
	_process_input(delta)


func _process_input(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_toggle_pauze(true)


func _toggle_pauze(paused: bool) -> void:
	Engine.time_scale = 0 if paused else 1
	if paused:
		_pause_overlay.show()
		SignalBus.on_pause.emit()
	else:
		_pause_overlay.hide()