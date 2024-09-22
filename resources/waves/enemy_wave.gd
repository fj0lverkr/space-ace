class_name EnemyWave
extends Resource

@export
var _enemy_scene: PackedScene
@export
var _speed: float
@export
var _gap: float
@export
var _number: int


func get_enemy_scene() -> PackedScene:
    return _enemy_scene


func get_speed() -> float:
    return _speed


func get_gap() -> float:
    return _gap


func get_number() -> int:
    return _number
