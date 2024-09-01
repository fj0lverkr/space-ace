class_name Explosion
extends AnimatedSprite2D

enum Type {EXPLOSION, BOOM}

const EXPLOSION: String = "explosion"
const BOOM: String = "boom"

var _type: Type

@onready
var _sfx: AudioStreamPlayer2D = $Sfx


func _ready() -> void:
	var animation_name: String = EXPLOSION if _type == Type.EXPLOSION else BOOM
	SoundManager.play_by_type(_sfx, SoundManager.SoundType.EXPLOSION)
	play(animation_name)


func setup(type: Type) -> void:
	_type = type


func _on_animation_finished() -> void:
	queue_free()
