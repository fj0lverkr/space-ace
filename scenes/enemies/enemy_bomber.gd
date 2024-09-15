class_name EnemyBomber
extends BaseEnemy

@onready
var _marker_gun: Marker2D = $MarkerGun

const HEALTH: Dictionary = {
	SubType.YELLOW: 130,
	SubType.BLUE: 190,
	SubType.RED: 255
}

const SPEED: Dictionary = {
	SubType.YELLOW: 60,
	SubType.BLUE: 80,
	SubType.RED: 100
}

const DROPRATES: Dictionary = {
	SubType.YELLOW: 50,
	SubType.BLUE: 30,
	SubType.RED: 25,
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
		_shoot(_marker_gun.global_position, false, dir)
	else:
		look_at(Vector2.DOWN)


func setup(s: SubType) -> void:
	_health_data = HEALTH
	_speed_data = SPEED
	_drop_rate_data = DROPRATES
	_points_data = POINTS

	super.setup(s)