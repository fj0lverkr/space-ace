class_name EnemyBomber
extends BaseEnemy

@onready
var _marker_gun: Marker2D = $MarkerGun

const HEALTH: Dictionary = {
	SubType.YELLOW: 30,
	SubType.BLUE: 60,
	SubType.RED: 120,
}

const SPEED: Dictionary = {
	SubType.YELLOW: 45,
	SubType.BLUE: 60,
	SubType.RED: 80,
}

const DROPRATES: Dictionary = {
	SubType.YELLOW: 20,
	SubType.BLUE: 20,
	SubType.RED: 15,
}

const POINTS: Dictionary = {
	SubType.YELLOW: 5,
	SubType.BLUE: 10,
	SubType.RED: 15,
}


func _ready() -> void:
	super._ready()
	sprite.play(_subtype)


func _process(delta: float) -> void:
	super._process(delta)
	if _player_ref != null:
		var dir: Vector2 = _player_ref.global_position - _marker_gun.global_position
		look_at(_player_ref.global_position)
		_shoot(_marker_gun.global_position, true, dir, 55)
	else:
		look_at(Vector2.DOWN)


func setup(s: SubType) -> void:
	_health_data = HEALTH
	_speed_data = SPEED
	_drop_rate_data = DROPRATES
	_points_data = POINTS

	super.setup(s)