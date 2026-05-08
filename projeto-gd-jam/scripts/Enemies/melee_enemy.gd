extends EnemyBase

signal damage_to_player(damage: int)

func _ready():
	
	super()
	health.max_hp = 12
	health.hp = 12
	dmg = 5
	speed = 60

func _physics_process(_delta):
	enemy_movement(_delta)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		damage_to_player.emit(dmg)
