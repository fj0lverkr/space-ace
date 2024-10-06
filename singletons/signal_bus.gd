extends Node

signal on_pause
signal on_continue
signal on_shoot(bt: BaseBullet.BulletType, dir: Vector2, speed: float, gp: Vector2)
signal on_shoot_missile(gp: Vector2)
signal on_try_powerup(chance: float, gp: Vector2, type: PowerUp.PowerUpType)
signal on_get_powerup(pt: PowerUp.PowerUpType)
signal on_explode(type: Explosion.Type, gp: Vector2)
signal on_request_enemy(type: BaseEnemy.Type, variant: BaseEnemy.SubType, path: Path2D, speed_factor: float)
signal on_player_hit(damage: int)
signal on_player_heal(health: int)
signal on_score_points(points: int)
signal on_game_over
signal on_shield_disable
signal on_spawn_saucer
signal on_saucer_removed