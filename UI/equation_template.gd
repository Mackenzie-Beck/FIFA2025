extends PanelContainer
class_name EquationTemplate

const TERM = preload("uid://c3lam4sdf8qcb")

@onready var term_slots: HBoxContainer = $MarginContainer/term_slots


var num_term_slots: int = 0


func _ready() -> void:
	for i in num_term_slots:
		var new_term = TERM.instantiate()
		new_term.set_term_text("_")
		term_slots.add_child(new_term)
		


func update_term_slots() -> void:
	for i in num_term_slots:
		var new_term = TERM.instantiate()
		new_term.set_term_text("_")
		term_slots.add_child(new_term)
