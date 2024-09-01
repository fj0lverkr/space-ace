class_name BaseEnemy
extends PathFollow2D

enum Type {ZIPPER, BIO, BOMBER}
enum SubType {YELLOW, BLUE, RED}

const FLICKER: String = "flicker"
const SUBTYPE: Dictionary = {
	SubType.YELLOW: "yellow",
	SubType.BLUE: "blue",
	SubType.RED: "red"
}

@onready
var sprite: AnimatedSprite2D = $Sprite
@onready
var animation_player: AnimationPlayer = $AnimationPlayer
@onready
var timer: Timer = $OutOfTime

var _health: int
var _speed: float
var _subtype: String

var _health_data: Dictionary
var _speed_data: Dictionary


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	progress += _speed * delta


func setup(s: SubType) -> void:
	_health = _health_data[s]
	_speed = _speed_data[s]
	_subtype = SUBTYPE[s]


func _on_out_of_time_timeout() -> void:
	animation_player.play(FLICKER)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == FLICKER:
		queue_free()
