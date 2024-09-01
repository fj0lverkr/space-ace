class_name ObjectFactory
extends Node2D

const PLAYER_BULLET: PackedScene = preload("res://scenes/bullets/player/player_bullet.tscn")
const ENEMY_BULLET: PackedScene = preload("res://scenes/bullets/enemy/enemy_bullet.tscn")
const ENEMY_BOMB: PackedScene = preload("res://scenes/bullets/bomb/enemy_bomb.tscn")
const POWER_UP: PackedScene = preload("res://scenes/power_up/power_up.tscn")
const EXPLOSION: PackedScene = preload("res://scenes/explosion/explosion.tscn")

const ADD_OBJECT: String = "_add_object"


func _ready() -> void:
    SignalBus.on_shoot.connect(_on_shoot)
    SignalBus.on_try_powerup.connect(_on_try_powerup)
    SignalBus.on_explode.connect(_on_explode)


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


func _on_try_powerup(_chance: float, type: PowerUp.Type, gp: Vector2) -> void:
    _chance = 100.0 if _chance >= 100.0 else _chance
    _chance = 0.0 if _chance <= 0.0 else _chance
    var dice_roll: float = randf_range(0, 100)
    if dice_roll > _chance:
        return
    
    var pu: PowerUp = POWER_UP.instantiate()
    pu.setup(type)
    call_deferred(ADD_OBJECT, pu, gp)


func _on_explode(type: Explosion.Type, gp: Vector2) -> void:
    var ex: Explosion = EXPLOSION.instantiate()
    ex.setup(type)
    call_deferred(ADD_OBJECT, ex, gp)