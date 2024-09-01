class_name BaseBullet
extends CollidableObject

enum BulletType {PLAYER, ENEMY, ENEMY_BOMB}

@onready
var _tip: Marker2D = $BulletTipMarker

var _direction: Vector2 = Vector2.UP
var _speed: float = 200.0


func _process(delta: float) -> void:
	position += delta * _speed * _direction


func setup(d: Vector2, s: float) -> void:
	_direction = d.normalized()
	_speed = s


func _blow_up() -> void:
	_speed = 0.0
	SignalBus.on_explode.emit(Explosion.Type.EXPLOSION, _tip.global_position)
	set_process(false)
	queue_free()


func _on_screen_exited() -> void:
	queue_free()


func _on_area_entered(_area: Area2D) -> void:
	_blow_up()