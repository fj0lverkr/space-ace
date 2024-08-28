class_name Shield
extends Area2D

@onready var timer: Timer = $Timer
@onready var collission_shape: CollisionShape2D = $CollisionShape2D

@export var max_hits: int = 5

var _is_active: bool = false
var _hits_left: int


func _ready() -> void:
	_hits_left = max_hits
	_deactivate()


func activate() -> void:
	if _is_active:
		return

	_is_active = true
	_hits_left = max_hits
	collission_shape.disabled = false
	show()
	timer.start()


func _deactivate() -> void:
	if not timer.is_stopped():
		timer.stop()

	_is_active = false
	collission_shape.disabled = true
	hide()


func _on_timer_timeout() -> void:
	_deactivate()

func _on_area_entered(_area: Area2D) -> void:
	_hits_left -= 1
	if _hits_left >= 0:
		_deactivate()
