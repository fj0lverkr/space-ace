extends Node

const MAIN: PackedScene = preload("res://scenes/main/main.tscn")
const LEVEL: PackedScene = preload("res://scenes/level/level.tscn")

var _score: int = 0
var _game_over: bool = false


func _ready() -> void:
	SignalBus.on_score_points.connect(_on_score_points)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)


func load_level_scene() -> void:
	_score = 0
	get_tree().change_scene_to_packed(LEVEL)


func get_score() -> int:
	return _score


func _on_score_points(points: int) -> void:
	_score += points


func set_game_over(is_over: bool) -> void:
	_game_over = is_over


func get_game_over() -> bool:
	return _game_over


func get_hi_score() -> int:
	var save_file: FileAccess = FileAccess.open("user://savegame.save", FileAccess.READ)
	if not save_file:
		_save_score()
		return _score
	else:
		var save_data: Dictionary = save_file.get_var()
		var hs: int = save_data["hi_score"]
		if hs >= _score:
			return hs
		else:
			_save_score()
			return _score


func _save_score() -> void:
	var save_file: FileAccess = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_data: Dictionary = {
		"hi_score": _score
	}
	save_file.store_var(save_data)
