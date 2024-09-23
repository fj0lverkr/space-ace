class_name EnemyWave
extends Resource

@export
var _enemy_type: BaseEnemy.Type
@export
var _enemy_variant: BaseEnemy.SubType
@export
var _gap: float
@export
var _number: int


func get_enemy_type() -> BaseEnemy.Type:
    return _enemy_type


func get_enemy_variant() -> BaseEnemy.SubType:
    return _enemy_variant


func get_gap() -> float:
    return _gap


func get_number() -> int:
    return _number
