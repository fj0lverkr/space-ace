class_name EnemyBomber
extends BaseEnemy

@onready
var _marker_gun: Marker2D = $MarkerGun

const HEALTH: Dictionary = {
	SubType.YELLOW: 15,
	SubType.BLUE: 20,
	SubType.RED: 25,
}

const SPEED: Dictionary = {
	SubType.YELLOW: 60,
	SubType.BLUE: 80,
	SubType.RED: 100,
}

const DROPRATES: Dictionary = {
	SubType.YELLOW: 30,
	SubType.BLUE: 20,
	SubType.RED: 15,
}

const POINTS: Dictionary = {
	SubType.YELLOW: 3,
	SubType.BLUE: 5,
	SubType.RED: 10,
}


func _ready() -> void:
	super._ready()
	sprite.play(_subtype)


func _process(delta: float) -> void:
	super._process(delta)
	if _player_ref != null:
		var dir: Vector2 = _player_ref.global_position - _marker_gun.global_position
		look_at(_player_ref.global_position)
		_shoot(_marker_gun.global_position, true, dir, 95)
	else:
		look_at(Vector2.DOWN)


func setup(s: SubType) -> void:
	_health_data = HEALTH
	_speed_data = SPEED
	_drop_rate_data = DROPRATES
	_points_data = POINTS

	super.setup(s)