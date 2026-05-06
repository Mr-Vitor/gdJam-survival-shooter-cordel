extends CanvasLayer

@onready var label = $LifeBar
var health

func _ready():
	await get_tree().process_frame

	var player = get_tree().get_first_node_in_group("player")
	print("PLAYER:", player)

	if player == null:
		push_error("Player NÃO encontrado!")
		return

	health = player.get_node_or_null("Health")
	print("HEALTH:", health)

	if health == null:
		push_error("Health NÃO encontrado!")
		return
	
	# conecta sinais
	health.damaged.connect(_update)
	health.healed.connect(_update)
	health.died.connect(_update)

	_update()

func _update(_a = null, _b = null):
	label.text = "HP: %d / %d" % [health.hp, health.max_hp]
