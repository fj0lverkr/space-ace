class_name EnemyBio
extends BaseEnemy

const HEALTH: Dictionary = {
	SubType.YELLOW: 120,
	SubType.BLUE: 175,
	SubType.RED: 250,
}

const SPEED: Dictionary = {
	SubType.YELLOW: 90,
	SubType.BLUE: 100,
	SubType.RED: 120,
}

const DROPRATES: Dictionary = {
	SubType.YELLOW: 50,
	SubType.BLUE: 30,
	SubType.RED: 25,
}

@onready
var _marker_gun: Marker2D = $MarkerGun


func _ready() -> void:
	super._ready()
	sprite.play(_subtype)


func _process(delta: float) -> void:
	super._process(delta)
	var dir: Vector2 = _player_ref.global_position - _marker_gun.global_position
	look_at(_player_ref.global_position)
	_shoot(_marker_gun.global_position, false, dir)


func setup(s: SubType) -> void:
	_health_data = HEALTH
	_speed_data = SPEED
	_drop_rate_data = DROPRATES
	super.setup(s)