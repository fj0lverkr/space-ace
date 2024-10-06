extends Node2D

@onready
var _pause_overlay: CanvasLayer = $Pause
@onready
var _bgm_player: AudioStreamPlayer = $BGM


func _ready() -> void:
	GameManager.set_game_over(false)
	Engine.time_scale = 1
	SoundManager.play_bgm(_bgm_player, SoundManager.Loop.MERCURY)
	SignalBus.on_continue.connect(_toggle_pauze.bind(false))
	SignalBus.on_game_over.connect(_on_game_over)

	# TODO cleanup these calls after the wave manager is implemented.
	# SignalBus.on_request_enemy.emit(BaseEnemy.Type.ZIPPER, BaseEnemy.SubType.RED, _remove_me)


func _process(delta: float) -> void:
	if not GameManager.get_game_over():
		_process_input(delta)

	else:
		# We remove these here as they might spawn in after the GameOver signal was emitted	
		for p: PowerUp in get_tree().get_nodes_in_group(Constants.GRP_PU):
			p.deactivate()

		if get_tree().get_nodes_in_group(Constants.GRP_PU).size() == 0:
			set_process(false)


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


func _on_game_over() -> void:
	GameManager.set_game_over(true)
	for e: BaseEnemy in get_tree().get_nodes_in_group(Constants.GRP_ENEMIES):
		e.destroy(false, false)