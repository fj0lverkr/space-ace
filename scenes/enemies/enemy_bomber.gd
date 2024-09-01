class_name EnemyBomber
extends BaseEnemy

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


func _ready() -> void:
	super._ready()
	sprite.play(_subtype)


func _process(delta: float) -> void:
	super._process(delta)


func setup(s: SubType) -> void:
	_health_data = HEALTH
	_speed_data = SPEED
	super.setup(s)