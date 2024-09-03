class_name BaseEnemy
extends PathFollow2D

enum Type {ZIPPER, BIO, BOMBER}
enum SubType {YELLOW, BLUE, RED}

const SUBTYPE: Dictionary = {
	SubType.YELLOW: "yellow",
	SubType.BLUE: "blue",
	SubType.RED: "red",
}
const LASER_TIMEOUT: Dictionary = {
	SubType.YELLOW: Vector2(1.0, 5.0),
	SubType.BLUE: Vector2(0.5, 3.0),
	SubType.RED: Vector2(0.5, 2.0),
}

@onready
var sprite: AnimatedSprite2D = $Sprite
@onready
var animation_player: AnimationPlayer = $AnimationPlayer
@onready
var timer: Timer = $OutOfTime
@onready
var laser_timer: Timer = $LaserTimer

var _health: int
var _speed: float
var _subtype: String
var _health_data: Dictionary
var _speed_data: Dictionary
var _can_shoot: bool = false
var _laser_timeout: Vector2
var _player_ref: Player


func _ready() -> void:
	_player_ref = _get_player_ref()
	if not _player_ref:
		queue_free()


func _process(delta: float) -> void:
	progress += _speed * delta


func _get_player_ref() -> Player:
	return get_tree().get_first_node_in_group(Constants.GRP_PLAYER)


func setup(s: SubType) -> void:
	_health = _health_data[s]
	_speed = _speed_data[s]
	_subtype = SUBTYPE[s]
	_laser_timeout = LASER_TIMEOUT[s]


func _on_out_of_time_timeout() -> void:
	animation_player.play(Constants.FLICKER)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == Constants.FLICKER:
		queue_free()


func _shoot(gp: Vector2, bomb: bool = false, dir: Vector2 = Vector2.DOWN, speed: float = 350.0) -> void:
	if _can_shoot:
		var bt: BaseBullet.BulletType = BaseBullet.BulletType.ENEMY_BOMB if bomb else BaseBullet.BulletType.ENEMY
		SignalBus.on_shoot.emit(bt, dir, speed, gp)
		_can_shoot = false
	elif laser_timer.is_stopped():
		Utils.set_and_start_timer(laser_timer, _laser_timeout.x, _laser_timeout.y)


func _on_laser_timer_timeout() -> void:
	_can_shoot = true
