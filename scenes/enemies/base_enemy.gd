class_name BaseEnemy
extends PathFollow2D

enum Type {ZIPPER, BIO, BOMBER, SAUCER}
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
var _animation_player: AnimationPlayer = $AnimationPlayer
@onready
var _laser_timer: Timer = $LaserTimer
@onready
var _health_bar: HealthBar = $HealthBar
@onready
var _oob_timer: Timer = $OutOfTime

var _health: int
var _speed: float
var _subtype: String
var _health_data: Dictionary
var _speed_data: Dictionary
var _can_shoot: bool = false
var _laser_timeout: Vector2
var _player_ref: Player
var _drop_rate: float
var _drop_rate_data: Dictionary
var _points: int
var _points_data: Dictionary


func _ready() -> void:
	_player_ref = _get_player_ref()
	if not _player_ref:
		queue_free()
	_health_bar.setup(_health, _health)


func _process(delta: float) -> void:
	progress += _speed * delta
	
	if progress_ratio > 0.99:
		queue_free()


func _get_player_ref() -> Player:
	return get_tree().get_first_node_in_group(Constants.GRP_PLAYER)


func setup(s: SubType) -> void:
	_health = _health_data[s]
	_speed = _speed_data[s]
	_subtype = SUBTYPE[s]
	_laser_timeout = LASER_TIMEOUT[s]
	_drop_rate = _drop_rate_data[s]
	_points = _points_data[s]


func destroy(do_points: bool, do_pu: bool) -> void:
	_speed = 0.0
	SignalBus.on_explode.emit(Explosion.Type.BOOM, global_position, 2.0)
	if do_points:
		SignalBus.on_score_points.emit(_points)
	_disable()
	if do_pu:
		SignalBus.on_try_powerup.emit(_drop_rate, global_position)
	_animation_player.play(Constants.FLICKER)


func update_speed(by: float) -> void:
	_speed *= by


func _on_out_of_time_timeout() -> void:
	queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == Constants.FLICKER:
		queue_free()


func _shoot(gp: Vector2, bomb: bool = false, dir: Vector2 = Vector2.DOWN, speed: float = 350.0) -> void:
	if _can_shoot:
		var bt: BaseBullet.BulletType = BaseBullet.BulletType.ENEMY_BOMB if bomb else BaseBullet.BulletType.ENEMY
		SignalBus.on_shoot.emit(bt, dir, speed, gp)
		_can_shoot = false
	elif _laser_timer.is_stopped():
		if bomb:
			GameUtils.set_and_start_timer(_laser_timer, _laser_timeout.x * 1.5, _laser_timeout.y * 2)
		else:
			GameUtils.set_and_start_timer(_laser_timer, _laser_timeout.x, _laser_timeout.y)


func _disable(wt: float = 0.0) -> void:
	await get_tree().create_timer(wt).timeout
	set_process(false)
	_can_shoot = false
	_laser_timer.stop()


func _enable() -> void:
	_oob_timer.stop()
	set_process(true)
	_laser_timer.start()


func _on_laser_timer_timeout() -> void:
	_can_shoot = true


func _on_area_entered(area: Area2D) -> void:
	var damage: int
	if area is CollidableObject:
		damage = area.get_damage()
	else:
		destroy(false, true)
	_health_bar.update_value(-damage)


func _on_health_bar_on_died() -> void:
	destroy(true, true)

func _on_screen_entered() -> void:
	_enable()
