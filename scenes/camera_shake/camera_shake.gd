class_name ShakeCamera
extends Camera2D

@export
var _shake_range: Vector2 = Vector2(-5.0, 5.0)

@onready
var _timer: Timer = $Timer

var _shake_offset: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_shake_offset = offset
	SignalBus.on_player_hit.connect(_on_player_hit)
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	offset = _get_random_offset()


func _get_random_offset() -> Vector2:
	return Vector2(_shake_offset.x + randf_range(_shake_range.x, _shake_range.y), _shake_offset.y + randf_range(_shake_range.x, _shake_range.y))


func _on_player_hit(_damage: int) -> void:
	set_process(true)
	_timer.start()


func _on_timer_timeout() -> void:
	set_process(false)
	offset = _shake_offset
