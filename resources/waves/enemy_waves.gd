class_name EnemyWaves
extends Resource

@export
var _waves: Array[EnemyWave]


func get_wave_for_count(count: int) -> EnemyWave:
    return _waves[count % _waves.size()]