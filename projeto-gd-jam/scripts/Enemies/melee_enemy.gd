extends EnemyBase

signal damage_to_player(damage: int)

func _ready():
	health = 12
	dmg = 5
	speed = 60


func _physics_process(_delta):
	enemy_movement()


func _on_area_2d_body_entered(_body):
	if !(_body.is_in_group("Enemies")):
		damage_to_player.emit(dmg)
