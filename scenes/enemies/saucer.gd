class_name Saucer
extends PathFollow2D

const SPEED: float = 20.0

@onready
var _health_bar: HealthBar = $HealthBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_health_bar.setup(250, 250)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * SPEED

	if progress_ratio > 0.99:
		queue_free()
