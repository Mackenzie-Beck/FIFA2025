extends PanelContainer


const TERM = preload("uid://c3lam4sdf8qcb")
@onready var term_container: GridContainer = $MarginContainer/GridContainer

signal term_set_updated(index:int, button: int, term_text : String)


var term_set = [
	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	"+", "-", "*", "=",
]

func _on_term_clicked(index : int, button: int, term_text : String) -> void:
	#print(index, " ", button, " ", term_text)
	term_set_updated.emit(index, button, term_text)

func set_term_set(tokens: Array, num: int) -> void:
	var shuffled_tokens = tokens.duplicate()
	shuffled_tokens.shuffle()
	
	for token in shuffled_tokens:
		var new_term = TERM.instantiate()
		new_term.set_term_text(token)
		term_container.add_child(new_term)
		new_term.term_clicked.connect(_on_term_clicked)
		
	for temp in range(0,tokens.size()):
		var new_term = TERM.instantiate()
		new_term.set_term_text(term_set.pick_random())
		term_container.add_child(new_term)
		new_term.term_clicked.connect(_on_term_clicked)


func set_term_slot(index : int, term_text: String) -> void:
	term_container.get_child(index).set_term_text(term_text)
