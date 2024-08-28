class_name Player
extends Area2D

const MARGINF: float = 20.0
const MARGIN: Vector2 = Vector2(MARGINF, MARGINF)

@export var speed: float = 250.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _bounds: Rect2


func _ready() -> void:
	_bounds = get_viewport_rect()
	_bounds.position += MARGIN
	_bounds.end -= MARGIN * 2


func _process(delta: float) -> void:
	var move_vector: Vector2 = _process_movement()
	var new_pos: Vector2 = global_position + move_vector * delta * speed
	global_position = new_pos.clamp(_bounds.position, _bounds.end)


func _process_movement() -> Vector2:
	var v: Vector2 = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	if v.x != 0:
		animation_player.play("turn")
		sprite.flip_h = v.x > 0
	else:
		animation_player.play("fly")

	return v.normalized()