class_name ObjectFactory
extends Node2D

const PLAYER_BULLET: PackedScene = preload("res://scenes/bullets/player/player_bullet.tscn")
const ENEMY_BULLET: PackedScene = preload("res://scenes/bullets/enemy/enemy_bullet.tscn")
const ENEMY_BOMB: PackedScene = preload("res://scenes/bullets/bomb/enemy_bomb.tscn")
const POWER_UP: PackedScene = preload("res://scenes/power_up/power_up.tscn")
const EXPLOSION: PackedScene = preload("res://scenes/explosion/explosion.tscn")
const ZIPPER: PackedScene = preload("res://scenes/enemies/enemy_zipper.tscn")
const BIOMECH: PackedScene = preload("res://scenes/enemies/enemy_bio.tscn")

const ADD_OBJECT: String = "_add_object"
const ADD_PATH_FOLLOWER: String = "_add_follower_to_path"


func _ready() -> void:
    SignalBus.on_shoot.connect(_on_shoot)
    SignalBus.on_try_powerup.connect(_on_try_powerup)
    SignalBus.on_explode.connect(_on_explode)
    SignalBus.on_request_enemy.connect(_on_request_enemy)


func _add_object(obj: Node, gp: Vector2) -> void:
    add_child(obj)
    obj.global_position = gp


func _add_follower_to_path(f: PathFollow2D, p: Path2D) -> void:
    p.add_child(f)


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
    ex.z_index = 10
    call_deferred(ADD_OBJECT, ex, gp)


func _on_request_enemy(type: BaseEnemy.Type, subtype: BaseEnemy.SubType, path: Path2D) -> void:
    var enemy: BaseEnemy
    match type:
        BaseEnemy.Type.ZIPPER:
            enemy = ZIPPER.instantiate()
        BaseEnemy.Type.BIO:
            enemy = BIOMECH.instantiate()
    enemy.setup(subtype)
    call_deferred(ADD_PATH_FOLLOWER, enemy, path)