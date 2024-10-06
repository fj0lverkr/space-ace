class_name EnemyZipper
extends BaseEnemy

@onready
var _marker_gun: Marker2D = $MarkerGun

const HEALTH: Dictionary = {
	SubType.YELLOW: 10,
	SubType.BLUE: 15,
	SubType.RED: 25,
}

const SPEED: Dictionary = {
	SubType.YELLOW: 150,
	SubType.BLUE: 175,
	SubType.RED: 200,
}

const DROPRATES: Dictionary = {
	SubType.YELLOW: 30,
	SubType.BLUE: 20,
	SubType.RED: 15,
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