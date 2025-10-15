extends PanelContainer


const TERM = preload("uid://c3lam4sdf8qcb")
@onready var grid_container: GridContainer = $MarginContainer/GridContainer

var term_set = [
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	"+", "-", "*", "=",
]



func update_term_set(tokens: Array, num: int) -> void:
	var shuffled_tokens = tokens.duplicate()
	shuffled_tokens.shuffle()
	
	for token in shuffled_tokens:
		var new_term = TERM.instantiate()
		new_term.set_term_text(token)
		grid_container.add_child(new_term)
		
	for temp in range(0,tokens.size()):
		var new_term = TERM.instantiate()
		new_term.set_term_text(term_set.pick_random())
		grid_container.add_child(new_term)
