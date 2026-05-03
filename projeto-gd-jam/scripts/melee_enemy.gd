extends EnemyBase

func _ready():
	self.health = 12
	self.dmg = 5
	self.speed = 70


func _physics_process(_delta):
	self.movement()
