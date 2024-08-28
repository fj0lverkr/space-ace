extends Control


func _on_btn_start_pressed() -> void:
	GameManager.load_level_scene()


func _on_btn_quit_pressed() -> void:
	get_tree().quit()
