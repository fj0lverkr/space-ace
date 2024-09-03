class_name Utils

static func set_and_start_timer(t: Timer, min_wt: float, max_wt: float) -> void:
    var wt: float = randf_range(min_wt, max_wt)
    t.start(wt)