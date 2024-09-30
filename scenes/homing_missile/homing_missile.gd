class_name HomingMissile
extends CollidableObject

const POINTS: int = 5

@export
var _rotation_speed_radians: float = 1.8
@export
var _speed: float = 120.0

@onready
var _smoke: CPUParticles2D = $CPUParticles2D

var _player_ref: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_game_over.connect(_on_game_over)
	_player_ref = get_tree().get_first_node_in_group(Constants.GRP_PLAYER)
	if !_player_ref:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir_to_player: Vector2 = global_position.direction_to(_player_ref.global_position)
	var angle_to_player: float = transform.x.angle_to(dir_to_player)
	rotate(sign(angle_to_player) * min(abs(angle_to_player), _rotation_speed_radians * delta))
	_smoke.gravity = transform.x * -980.0
	position += transform.x * _speed * delta


func set_direction(dir: Vector2) -> void:
	var angle_to_dir: float = transform.x.angle_to(dir)
	rotate(sign(angle_to_dir) * abs(angle_to_dir))


func _explode(get_points: bool, poi: Vector2) -> void:
	SignalBus.on_explode.emit(Explosion.Type.EXPLOSION, poi, 0.75)
	if get_points:
		SignalBus.on_score_points.emit(POINTS)
	queue_free()


func _on_on_area_entered(area: Area2D) -> void:
	_explode(not area is Player, area.global_position)


func _on_game_over() -> void:
	set_process(false)
	_explode(false, global_position)