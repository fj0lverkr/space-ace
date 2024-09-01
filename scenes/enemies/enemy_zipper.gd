class_name EnemyZipper
extends BaseEnemy

const HEALTH: Dictionary = {
	SubType.YELLOW: 100,
	SubType.BLUE: 150,
	SubType.RED: 200
}

const SPEED: Dictionary = {
	SubType.YELLOW: 100,
	SubType.BLUE: 120,
	SubType.RED: 150
}


func _ready() -> void:
	super._ready()
	sprite.play(_subtype)


func _process(delta: float) -> void:
	super._process(delta)


func setup(s: SubType) -> void:
	_health_data = HEALTH
	_speed_data = SPEED
	super.setup(s)