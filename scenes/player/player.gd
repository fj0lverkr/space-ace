class_name Player
extends Area2D

const VFXHEAL: String = "heal"
const VFXDIE: String = "die"

@export
var _speed: float = 250.0
@export
var _bullet_speed: float = 275
@export
var _max_health: int = 200
@export
var _start_health: int = 200
@export
var _powerup_health_boost: int = 15
@export
var _laser_time_out: float = 0.15

@onready
var _sprite: Sprite2D = $Sprite2D
@onready
var _animation_player: AnimationPlayer = $AnimationPlayer
@onready
var _vfx_player: AnimationPlayer = $EffectsPlayer
@onready
var _sfx_player: AudioStreamPlayer2D = $Sfx
@onready
var _gun_left: Marker2D = $GunLeft
@onready
var _gun_right: Marker2D = $GunRight
@onready
var _laser_time_out_timer: Timer = $LasertimeOut

var _bounds: Rect2
var _last_shot_left: bool = false
var _paused: bool = false
var _health: int
var _has_shield: bool = false
var _can_shoot: bool = true


func _ready() -> void:
	SignalBus.on_pause.connect(_toggle_pause.bind(true))
	SignalBus.on_continue.connect(_toggle_pause.bind(false))
	SignalBus.on_get_powerup.connect(_on_get_powerup)
	SignalBus.on_shield_disable.connect(_on_shield_disable)
	_bounds = get_viewport_rect()
	_bounds.position += Constants.MARGIN
	_bounds.end -= Constants.MARGIN * 2
	_health = _start_health


func _process(delta: float) -> void:
	var move_vector: Vector2 = _process_movement()
	var new_pos: Vector2 = global_position + move_vector * delta * _speed
	global_position = new_pos.clamp(_bounds.position, _bounds.end)

	if Input.is_action_just_pressed("shoot"):
		_shoot()


func _process_movement() -> Vector2:
	var v: Vector2 = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	if v.x != 0:
		_animation_player.play("turn")
		_sprite.flip_h = v.x > 0
	else:
		_animation_player.play("fly")

	return v.normalized()


func _toggle_pause(p: bool) -> void:
	_paused = p


func _shoot() -> void:
	if _paused or !_can_shoot:
		return

	_last_shot_left = !_last_shot_left
	var gp: Vector2 = _gun_left.global_position if _last_shot_left else _gun_right.global_position
	SignalBus.on_shoot.emit(BaseBullet.BulletType.PLAYER, Vector2.UP, _bullet_speed, gp)
	_can_shoot = false
	_laser_time_out_timer.start(_laser_time_out)

func get_health() -> int:
	return _health


func get_start_health() -> int:
	return _start_health


func get_max_health() -> int:
	return _max_health


func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		# this is handled by the PowerUp object
		return
	
	var damage: int
	if area is BaseBullet or area is HomingMissile:
		damage = area.get_damage()
	else:
		if _has_shield:
			return

		damage = _max_health
	SignalBus.on_player_hit.emit(damage)


func _on_get_powerup(type: PowerUp.PowerUpType) -> void:
	SoundManager.play_pu_activate(_sfx_player, type)
	
	if type != PowerUp.PowerUpType.POWERUP:
		_has_shield = true
		return
	
	_vfx_player.play(VFXHEAL)
	SignalBus.on_player_heal.emit(_powerup_health_boost)


func _on_shield_disable() -> void:
	_has_shield = false


func die() -> void:
	SignalBus.on_game_over.emit()
	queue_free()

func _on_lasertime_out_timeout() -> void:
	_can_shoot = true
