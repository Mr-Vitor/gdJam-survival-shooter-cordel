extends EnemyBase

signal damage_to_player(damage: int)

func _ready() -> void:
	super()
	health.max_hp = 8
	health.hp = 8
	dmg = 5
	speed = 75 

func _physics_process(_delta):
	enemy_movement(_delta)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		damage_to_player.emit(dmg)
		queue_free()
