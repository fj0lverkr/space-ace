extends ParallaxBackground

@export var scroll_speed: float = 50.0


func _process(delta: float) -> void:
	scroll_offset.y += delta * scroll_speed
