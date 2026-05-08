extends CanvasLayer

@onready var life_label = $LifeBar
@onready var xp_label = $XpBar

var health
var xp_system

func _ready():
	await get_tree().process_frame

	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		push_error("Player NÃO encontrado!")
		return

	# VIDA
	health = player.get_node_or_null("Health")

	if health != null:
		health.damaged.connect(_update_life)
		health.healed.connect(_update_life)
		health.died.connect(_update_life)
		
	
	# XP 
	xp_system = player.get_node_or_null("Level_System")
	
	if xp_system != null:
		xp_system.xp_gained.connect(_update_xp)
		xp_system.level_up.connect(_update_xp)

	_update_life()
	_update_xp()

# -----
# VIDA
# -----
func _update_life(_a = null, _b = null):
	life_label.text = "HP: %d / %d" % [health.hp, health.max_hp]


# -----
# XP 
# -----
func _update_xp(_a = null):
	xp_label.text = "Level %d | XP: %d/%d" % [
		xp_system.level,
		xp_system.xp,
		xp_system.xp_to_next_level
	]
