extends Node2D

@onready var pause_overlay: CanvasLayer = $Pause


func _ready() -> void:
	SignalBus.on_continue.connect(_toggle_pauze.bind(false))


func _process(delta: float) -> void:
	_process_input(delta)


func _process_input(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_toggle_pauze(true)


func _toggle_pauze(paused: bool) -> void:
	Engine.time_scale = 1 if paused else 0
	if paused:
		pause_overlay.show()
	else:
		pause_overlay.hide()