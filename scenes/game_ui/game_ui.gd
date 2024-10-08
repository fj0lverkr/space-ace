class_name GameUI
extends Control

@onready
var _health_bar: HealthBar = $CR/MC/HealthBar
@onready
var _score_label: Label = $CR/MC/ScoreLabel

var _player_ref: Player

func _ready() -> void:
	_player_ref = _get_player_ref()
	if not _player_ref:
		return

	_health_bar.setup(_player_ref.get_start_health(), _player_ref.get_max_health())
	_score_label.text = "0"
	SignalBus.on_player_hit.connect(_on_player_hit)
	SignalBus.on_player_heal.connect(_on_player_heal)
	SignalBus.on_score_points.connect(_on_score_points)


func _get_player_ref() -> Player:
	return get_tree().get_first_node_in_group(Constants.GRP_PLAYER)


func _on_player_hit(damage: int) -> void:
	_health_bar.update_value(-damage)


func _on_player_heal(health: int) -> void:
	_health_bar.update_value(health)

func _on_health_bar_on_died() -> void:
	_player_ref.die()


func _on_score_points(_p: int) -> void:
	_score_label.text = str(GameManager.get_score())
