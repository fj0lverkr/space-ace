extends Node

signal on_pause
signal on_continue
signal on_shoot(bt: BaseBullet.BulletType, dir: Vector2, speed: float, gp: Vector2)
signal on_try_powerup(chance: float, gp: Vector2, type: PowerUp.Type)
signal on_get_powerup(pt: PowerUp.Type)
signal on_explode(type: Explosion.Type, gp: Vector2)
signal on_request_enemy(type: BaseEnemy.Type, variant: BaseEnemy.SubType, path: Path2D)