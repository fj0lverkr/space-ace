class_name EnemyZipper
extends BaseEnemy

const HEALTH: Dictionary = {
	Variant.YELLOW: 100,
	Variant.BLUE: 150,
	Variant.RED: 200
}

const SPEED: Dictionary = {
	Variant.YELLOW: 100,
	Variant.BLUE: 120,
	Variant.RED: 150
}

const VARIANT: Dictionary = {
	Variant.YELLOW: "yellow",
	Variant.BLUE: "blue",
	Variant.RED: "red"
}

var _variant: String = "yellow"

func _ready() -> void:
	super._ready()
	sprite.play(_variant)


func _process(delta: float) -> void:
	super._process(delta)


func setup(t: Variant) -> void:
	_health = HEALTH[t]
	_speed = SPEED[t]
	_variant = VARIANT[t]
