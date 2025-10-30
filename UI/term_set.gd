extends PanelContainer


const TERM = preload("uid://c3lam4sdf8qcb")
@onready var term_grid: GridContainer = $MarginContainer/GridContainer

var term_set = [
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	"+", "-", "*", "=",
]


func set_term_set_data(term_set_data: TermSetData) -> void:
	if !term_set_data.term_set_updated.is_connected(populate_term_grid):
		term_set_data.term_set_updated.connect(populate_term_grid)
		populate_term_grid(term_set_data)


func populate_term_grid(term_set_data: TermSetData) -> void:
	#clears TermGrid
	for child in term_grid.get_children():
		child.queue_free()

	for term_data in term_set_data.term_datas:
		var term = TERM.instantiate()
		term_grid.add_child(term)
		
		term.term_clicked.connect(term_set_data.on_term_clicked)
		
		if term_data:
			term.set_term_data(term_data)


func clear_term_Set_data(term_Set_data: TermSetData) -> void:
	term_Set_data.term_Set_updated.disconnect(populate_term_grid)
	
	
#func update_term_set(tokens: Array, num: int) -> void:
	#var shuffled_tokens = tokens.duplicate()
	#shuffled_tokens.shuffle()
	#
	#for token in shuffled_tokens:
		#var new_term = TERM.instantiate()
		#new_term.set_term_text(token)
		#grid_container.add_child(new_term)
		#
	#for temp in range(0,tokens.size()):
		#var new_term = TERM.instantiate()
		#new_term.set_term_text(term_set.pick_random())
		#grid_container.add_child(new_term)
