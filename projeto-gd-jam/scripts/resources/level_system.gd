extends Node
class_name Level_System

signal level_up(new_level: int)

@onready var level: int = 1:
	set(value):
		level = value
		%Level.text = "Lvl " + str(value) 
		
@onready var xp: int = 0:
	set(value):
		xp = value
		%XP.value = value
		
@onready var xp_to_next_level: int = 10:
	set(value):
		xp_to_next_level = value
		%XP.max_value = value
		

func add_xp(amount: int):
	if amount <= 0:
		return
	xp += amount
	
	if xp >= xp_to_next_level:
		xp -= xp_to_next_level
		level += 1
		emit_signal("level_up", level)
		
		# aumento de XP progressivo
		xp_to_next_level = int(xp_to_next_level * 1.5)
