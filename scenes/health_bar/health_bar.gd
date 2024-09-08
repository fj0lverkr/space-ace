class_name HealthBar
extends TextureProgressBar

const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

@export
var level_low: int = 30
@export
var level_med: int = 65


var health: int


func _ready() -> void:
    value = health
    max_value = health
    _set_color()


func _set_color() -> void:
    var level: float = GameUtils.get_percentage(value, max_value)
    if level < level_low:
        tint_progress = COLOR_DANGER
    elif level < level_med:
        tint_progress = COLOR_MIDDLE
    else:
        tint_progress = COLOR_GOOD