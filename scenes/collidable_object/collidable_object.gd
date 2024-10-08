class_name CollidableObject
extends Area2D

@export
var _damage: int = 10

@onready
var _shape: CollisionShape2D = $Shape

signal on_area_entered(area: Area2D)


func get_damage() -> int:
    return _damage


func _disable_collision() -> void:
    _shape.call_deferred("set_disabled", true)


func _on_area_entered(area: Area2D) -> void:
    on_area_entered.emit(area)
