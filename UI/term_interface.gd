extends Control


#@onready var grabbed_term: Term = $GrabbedTerm
@onready var equation_template: EquationTemplate = $EquationTemplate
@onready var term_set: PanelContainer = $TermSet







func _on_term_clicked(button: int) -> void:
	print(button)
	
	
func set_equation_template(num : int) -> void:
	equation_template.num_term_slots = num 
	equation_template.update_term_slots()
	for term in equation_template.term_slots.get_children():
		term.term_clicked.connect(_on_term_clicked)

func set_term_set(equation: String, num: int) -> void:
	var tokens = []
	for char in equation:
		tokens.append(char)
	term_set.update_term_set(tokens, num)
	
