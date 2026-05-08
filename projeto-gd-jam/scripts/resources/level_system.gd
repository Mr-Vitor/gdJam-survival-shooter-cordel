extends Node
class_name Level_System

signal xp_gained(amount: int)
signal level_up(new_level: int)

@export var level: int = 1
@export var xp: int = 0
@export var xp_to_next_level: int = 10

func add_xp(amount: int):
	if amount <= 0:
		return
		
	xp += amount
	
	while xp >= xp_to_next_level:
		xp -= xp_to_next_level
		level += 1
		emit_signal("level_up", level)
		
		# aumento de XP progressivo
		xp_to_next_level = int(xp_to_next_level * 1.5)
	
	emit_signal("xp_gained", amount)
