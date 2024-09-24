class_name EnemyZipper
extends BaseEnemy

@onready
var _marker_gun: Marker2D = $MarkerGun

const HEALTH: Dictionary = {
	SubType.YELLOW: 10,
	SubType.BLUE: 15,
	SubType.RED: 20,
}

const SPEED: Dictionary = {
	SubType.YELLOW: 100,
	SubType.BLUE: 120,
	SubType.RED: 150
}

const DROPRATES: Dictionary = {
	SubType.YELLOW: 50,
	SubType.BLUE: 30,
	SubType.RED: 25,
}

const POINTS: Dictionary = {
	SubType.YELLOW: 1,
	SubType.BLUE: 3,
	SubType.RED: 5,
}


func _ready() -> void:
	super._ready()
	sprite.play(_subtype)


func _process(delta: float) -> void:
	super._process(delta)
	_shoot(_marker_gun.global_position)


func setup(s: SubType) -> void:
	_health_data = HEALTH
	_speed_data = SPEED
	_drop_rate_data = DROPRATES
	_points_data = POINTS
	super.setup(s)