extends TextureButton

@export var button_label_text: String = "Set me"

@onready var button_label: Label = $ButtonLabel

func _ready() -> void:
	button_label.text = button_label_text
