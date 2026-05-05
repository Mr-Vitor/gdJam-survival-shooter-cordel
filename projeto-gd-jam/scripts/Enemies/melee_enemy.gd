extends EnemyBase

signal damage_to_player

func _ready():
	self.health = 12
	self.dmg = 5
	self.speed = 60


func _physics_process(_delta):
	self.enemy_movement()


func _on_area_2d_body_entered(_body):
	if !(_body.is_in_group("Enemies")):
		damage_to_player.emit()
