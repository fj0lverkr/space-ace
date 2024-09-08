class_name PowerUp
extends CollidableObject

enum Type {POWERUP, SHIELD}

@export
var _life_time: float = 10.0
@export
var _speed: float = 50.0

@onready
var _sprite: Sprite2D = $Sprite2D
@onready
var _animation: AnimationPlayer = $AnimationPlayer
@onready
var _timer: Timer = $Timer
@onready
var _sfx: AudioStreamPlayer2D = $Sfx

const FLICKER: String = "flicker"
const TEX_POWERUP: String = "res://assets/misc/powerupGreen_bolt.png"
const TEX_SHIELD: String = "res://assets/misc/shield_gold.png"

var _textures: Dictionary = {
	PowerUp.Type.POWERUP: TEX_POWERUP,
	PowerUp.Type.SHIELD: TEX_SHIELD,
}

var _type: PowerUp.Type


func _ready() -> void:
	_timer.wait_time = _life_time
	
	if _textures.has(_type):
		_sprite.texture = load(_textures[_type])

	SoundManager.play_pu_deploy(_sfx)

	_timer.start()


func _process(delta: float) -> void:
	global_position += Vector2.DOWN * _speed * delta


func setup(type: Type = -1) -> void:
	if type > -1:
		_type = type
	else:
		_type = randi() % 2


func _on_timer_timeout() -> void:
	_deactivate()


func _deactivate(do_flicker: bool = true) -> void:
	_timer.stop()
	if do_flicker:
		_animation.play(FLICKER)
	else:
		queue_free()


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == FLICKER:
		queue_free()


func _on_area_entered(_area: Area2D) -> void:
	SignalBus.on_get_powerup.emit(_type)
	_deactivate(false)
