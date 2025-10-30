extends Control


#@onready var grabbed_term: Term = $GrabbedTerm
@onready var equation_template: EquationTemplate = $EquationTemplate
@onready var term_set: PanelContainer = $TermSet
@onready var grabbed_term: Term = $GrabbedTerm




func _physics_process(delta: float) -> void:
	if grabbed_term.visible:
		grabbed_term.global_position = get_global_mouse_position() + Vector2(5,5)


func _on_term_clicked(button: int, term_text) -> void:
	match button:
		1:
			if grabbed_term.visible == false:
				grabbed_term.set_term_text(term_text)
				grabbed_term.visible = !grabbed_term.visible
				print(term_text)
		2:
			print("right click")
	
	
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
	for term in term_set.grid_container.get_children():
		term.term_clicked.connect(_on_term_clicked)
	
