class_name HomingMissile
extends CollidableObject

const POINTS: int = 5

@export
var _rotation_speed_radians: float = 1.8
@export
var _speed: float = 80.0

@onready
var _smoke: CPUParticles2D = $CPUParticles2D

var _player_ref: Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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


func _on_on_area_entered(area: Area2D) -> void:
	var poi: Vector2 = area.global_position
	SignalBus.on_explode.emit(Explosion.Type.EXPLOSION, poi, 0.75)
	if not area is Player:
		SignalBus.on_score_points.emit(POINTS)
	queue_free()
