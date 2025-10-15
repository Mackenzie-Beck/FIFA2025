extends Control


#@onready var grabbed_term: Term = $GrabbedTerm
@onready var equation_template: EquationTemplate = $EquationTemplate





func _ready() -> void:
	for term in equation_template.term_slots.get_children():
		term.term_clicked.connect(_on_term_clicked)




func _on_term_clicked(button: int) -> void:
	print(button)
	
func set_number_of_terms(num : int) -> void:
	print(num)
	equation_template.num_term_slots = num 
	equation_template.update_term_slots()
