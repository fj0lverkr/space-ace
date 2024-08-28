class_name Shield
extends Area2D

@onready var timer: Timer = $Timer
@onready var collission_shape: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound

@export var max_hits: int = 5

var _is_active: bool = false
var _hits_left: int


func _ready() -> void:
	_hits_left = max_hits
	#_deactivate(false)
	activate()


func activate() -> void:
	if _is_active:
		return

	_is_active = true
	_hits_left = max_hits
	collission_shape.call_deferred("set_disabled", false)
	show()
	timer.start()


func _deactivate(do_flicker: bool = true) -> void:
	timer.stop()
	_is_active = false
	collission_shape.call_deferred("set_disabled", true)
	if do_flicker:
		animation_player.play("flicker")
	else:
		hide()


func _on_timer_timeout() -> void:
	_deactivate()


func _on_area_entered(_area: Area2D) -> void:
	_hits_left -= 1
	animation_player.play("hit")
	if _hits_left == 0:
		_deactivate()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "flicker":
		hide()
