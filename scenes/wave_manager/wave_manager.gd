class_name WaveMananger
extends Node2D

const WAVES: EnemyWaves = preload("res://resources/waves/waves.tres")
const SPEEDFACTOR: float = 1.02
const SPAWNGAPFACTOR: float = 0.97

@onready
var _paths: Node2D = $Paths
@onready
var _spawn_timer: Timer = $SpawnTimer

var _wave_count: int = 0
var _last_path_index: int = -1
var _wave_gap: float = 4.0
var _paths_list: Array = []
var _can_spawn: bool = true
var _speed_factor: float = 1.0
var _spawn_gap_factor: float = 1.0


func _ready() -> void:
	SignalBus.on_game_over.connect(_on_game_over)
	_paths_list = _paths.get_children()
	_spawn_wave()


func _spawn_wave() -> void:
	if !_can_spawn:
		return

	if WAVES.is_first_wave(_wave_count) and _wave_count != 0:
		_speed_factor *= SPEEDFACTOR
		_spawn_gap_factor *= SPAWNGAPFACTOR

	_set_random_path_index()
	var path: Path2D = _paths_list[_last_path_index]
	var wave: EnemyWave = WAVES.get_wave_for_count(_wave_count)
	var wave_gap: float = wave.get_gap() * _spawn_gap_factor

	for i: int in range(wave.get_number()):
		SignalBus.on_request_enemy.emit(wave.get_enemy_type(), wave.get_enemy_variant(), path, _speed_factor)
		await get_tree().create_timer(wave_gap).timeout

	_wave_count += 1
	_spawn_timer.start(_wave_gap)


func _set_random_path_index() -> void:
	var all_indexes: Array = range(_paths_list.size())
	all_indexes.erase(_last_path_index)
	_last_path_index = all_indexes.pick_random()


func _on_spawn_timer_timeout() -> void:
	_spawn_wave()


func _on_game_over() -> void:
	_can_spawn = false
