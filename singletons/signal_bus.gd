extends Node

signal on_pause
signal on_continue
signal on_shoot(bt: BaseBullet.BulletType, dir: Vector2, speed: float, gp: Vector2)
signal on_try_powerup(chance: float, type: PowerUp.Type, gp: Vector2)
signal on_get_powerup(pt: PowerUp.Type)
signal on_explode(type: Explosion.Type, gp: Vector2)
signal on_request_enemy(type: BaseEnemy.Type, variant: BaseEnemy.Variant) # TODO add a Path2D here later