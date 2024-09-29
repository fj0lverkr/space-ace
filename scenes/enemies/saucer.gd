class_name Saucer
extends PathFollow2D

const WAIT_TIME: float = 7.0
const WAIT_VAR: float = 1.0
const PB: String = "parameters/playback"
const SHOOT: String = "shoot"
const DIE: String = "die"
const BOOM_TIMEOUT: float = 0.2

@export
var _health: int = 1500
@export
var _points: int = 150

@onready
var _health_bar: HealthBar = $HealthBar
@onready
var _anim_tree: AnimationTree = $AnimationTree
@onready
var _state_machine: AnimationNodeStateMachinePlayback = _anim_tree[PB]
@onready
var _shoot_timer: Timer = $ShootTimer
@onready
var _hitbox: CollidableObject = $Hitbox
@onready
var _sprite: Sprite2D = $Hitbox/Sprite2D
@onready
var _sound: AudioStreamPlayer2D = $Sound
@onready
var _booms: Node2D = $Hitbox/Booms

var _speed: float = 20.0
var _is_shooting: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_health_bar.setup(_health, _health)
	GameUtils.set_and_start_timer(_shoot_timer, WAIT_TIME, WAIT_TIME + WAIT_VAR)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _is_shooting:
		return

	progress += delta * _speed

	if progress_ratio > 0.99:
		queue_free()


func _on_shoot_timer_timeout() -> void:
	_shoot()


func _shoot() -> void:
	_is_shooting = true
	_state_machine.travel(SHOOT)
	_sprite.rotation = _hitbox.rotation
	SoundManager.play_saucer_open(_sound)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == SHOOT:
		_is_shooting = false
		GameUtils.set_and_start_timer(_shoot_timer, WAIT_TIME, WAIT_VAR)


func _on_hitbox_on_area_entered(area: Area2D) -> void:
	var damage: int
	if area is CollidableObject:
		damage = area.get_damage()

	_health_bar.update_value(-damage)


func _on_health_bar_on_died() -> void:
	_health_bar.hide()
	_hitbox._disable_collision()
	_speed = 0.0
	SignalBus.on_score_points.emit(_points)
	_state_machine.travel(DIE)
	for m: Marker2D in _booms.get_children():
		SignalBus.on_explode.emit(Explosion.Type.BOOM, m.global_position, 2.0)
		await get_tree().create_timer(BOOM_TIMEOUT).timeout
