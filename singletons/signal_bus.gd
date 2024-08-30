extends Node

signal on_continue
signal on_shoot(bt: BaseBullet.BulletType, dir: Vector2, speed: float, gp: Vector2)
signal on_try_powerup(chance: float, type: PowerUp.Type, gp: Vector2)
signal on_get_powerup(pt: PowerUp.Type)