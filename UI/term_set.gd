extends PanelContainer


const TERM = preload("uid://c3lam4sdf8qcb")
@onready var grid_container: GridContainer = $MarginContainer/GridContainer

func update_term_set(tokens: Array, num: int) -> void:
	var shuffled_tokens = tokens.duplicate()
	shuffled_tokens.shuffle()
	
	for token in shuffled_tokens:
		var new_term = TERM.instantiate()
		new_term.set_term_text(token)
		grid_container.add_child(new_term)
