extends ParallaxBackground

@export var scroll_speed: float = 50.0


func _process(delta: float) -> void:
	for l: Node in get_children():
		if l is ParallaxLayer:
			l.motion_offset.y += delta * scroll_speed * randf_range(0.2, 0.5)
