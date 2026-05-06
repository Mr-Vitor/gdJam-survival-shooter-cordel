extends EnemyBase

signal damage_to_player(damage: int)

func _ready() -> void:
	health = 25
	dmg = 12
	speed = 40

func _physics_process(_delta):
	enemy_movement()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		damage_to_player.emit(dmg)
