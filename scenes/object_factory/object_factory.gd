class_name ObjectFactory
extends Node2D

const PLAYER_BULLET: PackedScene = preload("res://scenes/bullets/player/player_bullet.tscn")
const ENEMY_BULLET: PackedScene = preload("res://scenes/bullets/enemy/enemy_bullet.tscn")
const ENEMY_BOMB: PackedScene = preload("res://scenes/bullets/bomb/enemy_bomb.tscn")

const ADD_OBJECT: String = "_add_object"


func _ready() -> void:
    SignalBus.on_shoot.connect(_on_shoot)


func _add_object(obj: Node, gp: Vector2) -> void:
    add_child(obj)
    obj.global_position = gp


func _on_shoot(bt: BaseBullet.BulletType, dir: Vector2, speed: float, gp: Vector2) -> void:
    var scene: BaseBullet
    match bt:
        BaseBullet.BulletType.PLAYER:
            scene = PLAYER_BULLET.instantiate()
        BaseBullet.BulletType.ENEMY:
            scene = ENEMY_BULLET.instantiate()
        BaseBullet.BulletType.ENEMY_BOMB:
            scene = ENEMY_BOMB.instantiate()

    scene.setup(dir, speed)
    call_deferred(ADD_OBJECT, scene, gp)