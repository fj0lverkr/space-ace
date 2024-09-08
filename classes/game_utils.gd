class_name GameUtils

static func set_and_start_timer(t: Timer, min_wt: float, max_wt: float) -> void:
    var wt: float = randf_range(min_wt, max_wt)
    t.start(wt)


static func get_percentage(part: float, whole: float) -> float:
    return (part / whole) * 100.0