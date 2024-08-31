extends Control

@onready
var _bgm_player: AudioStreamPlayer = $BGM


func _ready() -> void:
	SoundManager.play_bgm(_bgm_player, SoundManager.Loop.TITLE)


func _on_btn_start_pressed() -> void:
	GameManager.load_level_scene()


func _on_btn_quit_pressed() -> void:
	get_tree().quit()
