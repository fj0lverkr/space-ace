class_name Saucer
extends PathFollow2D

const SPEED: float = 20.0
const WAIT_TIME: float = 7.0
const WAIT_VAR: float = 1.0
const PB: String = "parameters/playback"
const SHOOT: String = "shoot"

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

var _is_shooting: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_health_bar.setup(250, 250)
	GameUtils.set_and_start_timer(_shoot_timer, WAIT_TIME, WAIT_TIME + WAIT_VAR)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _is_shooting:
		return

	progress += delta * SPEED

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