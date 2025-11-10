extends Control


#@onready var grabbed_term: Term = $GrabbedTerm
@onready var equation_template: EquationTemplate = $EquationTemplate
@onready var term_set: PanelContainer = $TermSet
@onready var grabbed_term: Term = $GrabbedTerm

var correct_equation : String

signal equation_is_correct
signal equation_is_false

func _ready() -> void:
	
	# connect signals 
	equation_is_correct.connect(equation_template._on_equation_is_correct)
	equation_is_false.connect(equation_template._on_equation_is_false)
	
	term_set.term_set_updated.connect(_on_term_set_updated)
	equation_template.equation_template_updated.connect(_equation_template_updated)

func _physics_process(delta: float) -> void:
	if grabbed_term.visible:
		grabbed_term.global_position = get_global_mouse_position() + Vector2(5,5)



func _equation_template_updated(index: int, button: int, term_text : String):
		match button:
			1:
				#put term from term set into equation template
				if grabbed_term.visible:
					equation_template.term_slots.get_child(index).set_term_text(grabbed_term.term_label.text)
					grabbed_term.visible = !grabbed_term.visible
				#grab term from equation template 
				elif !grabbed_term.visible and equation_template.term_slots.get_child(index).term_label.text != "___":
					grabbed_term.visible = !grabbed_term.visible
					grabbed_term.term_label.text = term_text
					equation_template.set_term_slot(index, "___")
					
					
		check_equation_correct()
				
				
func _on_term_set_updated(index:int, button: int, term_text : String):
	match button:
		1:
			if !grabbed_term.visible:
				grabbed_term.visible = !grabbed_term.visible
				grabbed_term.term_label.text = term_text
				term_set.set_term_slot(index, "___")
				#player should not be able to place a term when there is another number in that slot
			elif grabbed_term.visible and term_text == "___":
				grabbed_term.visible = !grabbed_term.visible
				term_set.set_term_slot(index, grabbed_term.term_label.text)
				

func check_equation_correct():
	if equation_template.get_equation() == correct_equation:
		equation_is_correct.emit()
	elif equation_template.get_empty_term_slots() == 0:
		equation_is_false.emit()

func set_equation_template(equation : String, num : int) -> void:
	var tmp_string : String
	var tokens = []
	
	#remove characters unneccesary for display
	for char in equation:
		if char != "*":
			tokens.append(char)
	#convert tokens to string
	for token in tokens:
		tmp_string = tmp_string + token
		
	set_correct_equation(tmp_string)
	equation_template.num_term_slots = num 
	equation_template.set_term_slots()

	


func set_term_set(equation: String, num: int) -> void:
	var tokens = []
	for char in equation:
		tokens.append(char)
	term_set.set_term_set(tokens, num)

func set_correct_equation(string : String):
	correct_equation = string
	print("set_correct_equation in equation_template.gd")
	print(correct_equation)
