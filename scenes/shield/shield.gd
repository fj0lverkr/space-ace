class_name Shield
extends Area2D

@onready
var _timer: Timer = $Timer
@onready
var _collission_shape: CollisionShape2D = $CollisionShape2D
@onready
var _animation_player: AnimationPlayer = $AnimationPlayer

@export
var _max_hits: int = 5

var _is_active: bool = false
var _hits_left: int


func _ready() -> void:
	SignalBus.on_get_powerup.connect(_on_get_powerup)
	_hits_left = _max_hits
	_deactivate(false)


func activate() -> void:
	if _is_active:
		return

	_is_active = true
	_hits_left = _max_hits
	_collission_shape.call_deferred("set_disabled", false)
	show()
	_timer.start()


func _deactivate(do_flicker: bool = true) -> void:
	_timer.stop()
	_is_active = false
	_collission_shape.call_deferred("set_disabled", true)
	if do_flicker:
		_animation_player.play("flicker")
	else:
		hide()

	SignalBus.on_shield_disable.emit()


func _on_timer_timeout() -> void:
	_deactivate()


func _on_area_entered(area: Area2D) -> void:
	_hits_left = _hits_left - 1 if area is BaseBullet else 0
	_animation_player.play("hit")
	if _hits_left == 0:
		_deactivate()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == Constants.FLICKER:
		hide()


func _on_get_powerup(pt: PowerUp.PowerUpType) -> void:
	if pt != PowerUp.PowerUpType.SHIELD:
		return

	if _is_active:
		_hits_left += _max_hits
		_timer.stop()
		_timer.start()

	else:
		activate()