extends CanvasLayer


func _on_btn_continue_pressed() -> void:
	SignalBus.on_continue.emit()


func _on_btn_main_pressed() -> void:
	GameManager.load_main_scene()


func _on_btn_quit_pressed() -> void:
	get_tree().quit()
