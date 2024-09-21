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
	get_tree().change_scene_to_packed(LEVEL)


func get_score() -> int:
	return _score


func _on_score_points(points: int) -> void:
	_score += points


func set_game_over(is_over: bool) -> void:
	_game_over = is_over


func get_game_over() -> bool:
	return _game_over