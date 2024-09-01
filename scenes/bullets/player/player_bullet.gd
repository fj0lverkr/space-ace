class_name PlayerBullet
extends BaseBullet

@onready
var _sfx: AudioStreamPlayer2D = $Sfx


func _ready() -> void:
    SoundManager.play_by_type(_sfx, SoundManager.SoundType.LASER, 1)