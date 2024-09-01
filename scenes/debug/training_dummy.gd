extends Area2D


func _on_area_entered(area: Area2D) -> void:
	SignalBus.on_shoot.emit(BaseBullet.BulletType.ENEMY, Vector2.DOWN, 120.0, area.global_position)
