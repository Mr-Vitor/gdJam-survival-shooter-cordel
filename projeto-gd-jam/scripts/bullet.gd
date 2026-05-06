extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

signal deal_damage

var direction : Vector2
var speed := 150

func _ready():
	get_tree().create_timer(3).timeout.connect(queue_free)

func _physics_process(_delta):
	if direction:
		global_position += direction * speed * _delta
		look_at(global_position + direction)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		deal_damage.emit()

		queue_free()
