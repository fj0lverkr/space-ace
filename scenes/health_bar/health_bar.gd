class_name HealthBar
extends TextureProgressBar

signal on_died

const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

@export
var level_low: int = 30
@export
var level_med: int = 65

var _died: bool = false


func setup(health: int, max_health: int) -> void:
    max_value = max_health
    value = health
    _set_color()


func update_value(val: int) -> void:
    ## Adds val to value, clamping to max_value
    if not _died:
        value += val
        _set_color()
        if value <= 0:
            _died = true
            on_died.emit()


func _set_color() -> void:
    var level: float = GameUtils.get_percentage(value, max_value)
    if level < level_low:
        tint_progress = COLOR_DANGER
    elif level < level_med:
        tint_progress = COLOR_MIDDLE
    else:
        tint_progress = COLOR_GOOD