class_name Player
extends Area2D

@export
var _speed: float = 250.0
@export
var _bullet_speed: float = 275

@onready
var _sprite: Sprite2D = $Sprite2D
@onready
var _animation_player: AnimationPlayer = $AnimationPlayer
@onready
var _gun_left: Marker2D = $GunLeft
@onready
var _gun_right: Marker2D = $GunRight

var _bounds: Rect2
var _last_shot_left: bool = false
var _paused: bool = false


func _ready() -> void:
	SignalBus.on_pause.connect(_toggle_pause.bind(true))
	SignalBus.on_continue.connect(_toggle_pause.bind(false))
	_bounds = get_viewport_rect()
	_bounds.position += Constants.MARGIN
	_bounds.end -= Constants.MARGIN * 2


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
	if _paused:
		return

	_last_shot_left = !_last_shot_left
	var gp: Vector2 = _gun_left.global_position if _last_shot_left else _gun_right.global_position
	SignalBus.on_shoot.emit(BaseBullet.BulletType.PLAYER, Vector2.UP, _bullet_speed, gp)
