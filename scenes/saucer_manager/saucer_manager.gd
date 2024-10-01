class_name SaucerManager
extends Node2D

const SAUCER: PackedScene = preload("res://scenes/enemies/saucer.tscn")

@export
var wait_time: float = 15.0
@export
var timer_variance: float = 3.0

@onready
var _paths_container: Node2D = $Paths

var _paths: Array[Path2D]
var _last_path_index: int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_paths.append_array(_paths_container.get_children())
	SignalBus.on_spawn_saucer.connect(_on_spawn_saucer)


func _set_active_path() -> void:
	var all_path_indexes: Array = range(_paths.size())
	if _last_path_index > -1:
		all_path_indexes.erase(_last_path_index)

	_last_path_index = all_path_indexes.pick_random()


func _on_spawn_saucer() -> void:
	_set_active_path()
	var saucer: Saucer = SAUCER.instantiate()
	_paths[_last_path_index].add_child(saucer)