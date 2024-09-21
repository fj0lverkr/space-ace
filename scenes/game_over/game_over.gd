class_name GameOverUi

extends Control

@onready
var score_label: Label = $VBoxContainer/Score
@onready
var continue_label: Label = $VBoxContainer/ContinueLabel
@onready
var continue_timer: Timer = $ContinueTimer

var _can_continue: bool = false


func _ready() -> void:
    continue_label.text = " "
    SignalBus.on_game_over.connect(_on_game_over)


func _process(_delta: float) -> void:
    if not _can_continue:
        return

    if Input.is_action_just_pressed("shoot"):
        GameManager.load_main_scene()


func _on_game_over() -> void:
    var score_text: String = "Score: %s Hi-score: NaN" % GameManager.get_score()
    score_label.text = score_text
    continue_timer.start()
    show()


func _on_continue_timer_timeout() -> void:
    _can_continue = true
    continue_label.text = "Shoot to continue..."
