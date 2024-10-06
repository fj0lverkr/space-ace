class_name EnemyWaves
extends Resource

@export
var _waves: Array[EnemyWave]


func get_random_wave() -> EnemyWave:
    return _waves.pick_random()


func is_first_wave(count: int) -> bool:
    return count % int(_waves.size() / 3.0) == 0