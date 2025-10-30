extends PanelContainer
class_name EquationTemplate

const TERM = preload("uid://c3lam4sdf8qcb")

@onready var term_slots: HBoxContainer = $MarginContainer/term_slots

signal equation_template_updated(index: int, button: int, term_text : String)

var num_term_slots: int = 0




func _on_term_clicked(index : int, button: int, term_text : String) -> void:
	equation_template_updated.emit(index, button, term_text)

func _ready() -> void:
	for i in num_term_slots:
		var new_term = TERM.instantiate()
		new_term.set_term_text("___")
		term_slots.add_child(new_term)
		new_term.term_clicked.connect(_on_term_clicked)
		


func set_term_slots() -> void:
	for i in num_term_slots:
		var new_term = TERM.instantiate()
		new_term.set_term_text("___")
		term_slots.add_child(new_term)
		new_term.term_clicked.connect(_on_term_clicked)

func set_term_slot(index : int, term_text: String) -> void:
	term_slots.get_child(index).set_term_text(term_text)
	
