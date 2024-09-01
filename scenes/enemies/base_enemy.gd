class_name BaseEnemy
extends PathFollow2D

enum Type {ZIPPER, BIO, BOMBER}
enum Variant {YELLOW, BLUE, RED}

const FLICKER: String = "flicker"

@onready
var sprite: AnimatedSprite2D = $Sprite
@onready
var animation_player: AnimationPlayer = $AnimationPlayer
@onready
var timer: Timer = $OutOfTime

var _health: int = 100
var _speed: float = 100
var _duration: float = 30


func _ready() -> void:
	rotates = false
	timer.wait_time = _duration
	timer.start()


func _process(delta: float) -> void:
	progress += _speed * delta


func setup(_t: Variant) -> void:
	pass


func _on_out_of_time_timeout() -> void:
	animation_player.play(FLICKER)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == FLICKER:
		queue_free()
