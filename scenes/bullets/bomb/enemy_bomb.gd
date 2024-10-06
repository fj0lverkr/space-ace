class_name EnemyBombBullet
extends BaseBullet

@export
var _rotation_speed_radians: float = 1.8

@onready
var _sfx: AudioStreamPlayer2D = $Sfx


func _ready() -> void:
    super._ready()


    SoundManager.play_by_type(_sfx, SoundManager.SoundType.LASER)


func _process(delta: float) -> void:
    var dir_to_player: Vector2 = global_position.direction_to(_player_ref.global_position)
    var angle_to_player: float = transform.x.angle_to(dir_to_player)
    rotate(sign(angle_to_player) * min(abs(angle_to_player), _rotation_speed_radians * delta))
    position += transform.x * _speed * delta