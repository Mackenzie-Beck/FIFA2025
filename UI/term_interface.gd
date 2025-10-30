extends Control


#@onready var grabbed_term: Term = $GrabbedTerm
@onready var equation_template: EquationTemplate = $EquationTemplate
@onready var term_set: PanelContainer = $TermSet
@onready var grabbed_term: Term = $GrabbedTerm


func _ready() -> void:
	term_set.term_set_updated.connect(_on_term_set_updated)

func _physics_process(delta: float) -> void:
	if grabbed_term.visible:
		grabbed_term.global_position = get_global_mouse_position() + Vector2(5,5)

func _on_term_set_updated(button: int, term_text : String):
	match button:
		1:
			grabbed_term.visible = !grabbed_term.visible
			grabbed_term.term_label.text = term_text

func set_equation_template(num : int) -> void:
	equation_template.num_term_slots = num 
	equation_template.update_term_slots()


func set_term_set(equation: String, num: int) -> void:
	var tokens = []
	for char in equation:
		tokens.append(char)
	term_set.set_term_set(tokens, num)

	
