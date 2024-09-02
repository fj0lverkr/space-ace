class_name EnemyBullet
extends BaseBullet

@onready
var _sfx: AudioStreamPlayer2D = $Sfx


func _ready() -> void:
    super._ready()
    SoundManager.play_by_type(_sfx, SoundManager.SoundType.LASER)