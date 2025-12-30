extends Control


#@onready var grabbed_term: Term = $GrabbedTerm
@onready var equation_template: EquationTemplate = $EquationTemplate
@onready var term_set: PanelContainer = $TermSet
@onready var grabbed_term: Term = $GrabbedTerm
@onready var points: Label = $PanelContainer/VBoxContainer/HBoxContainer/Points


var correct_equation : String

signal equation_is_correct
signal equation_is_false
signal update_equation(equation : String)



func _ready() -> void:
	
	# connect signals 
	equation_is_correct.connect(equation_template._on_equation_is_correct)
	equation_is_correct.connect(_on_equation_is_correct)
	equation_is_false.connect(equation_template._on_equation_is_false)
	equation_template.skip_current_equation.connect(skip_equation)
	term_set.term_set_updated.connect(_on_term_set_updated)
	equation_template.equation_template_updated.connect(_equation_template_updated)

func _physics_process(delta: float) -> void:
	if grabbed_term.visible:
		grabbed_term.global_position = get_global_mouse_position() + Vector2(5,5)


func tokenize_equation(equation: String) -> Array:
	var tokens = []
	var current_token = ""
	
	for i in range(equation.length()):
		var char = equation[i]
		
		# If it's a digit, accumulate it
		if char.is_valid_int():
			current_token += char
		else:
			# If we have accumulated digits, add them as a token
			if current_token != "":
				tokens.append(current_token)
				current_token = ""
			
			# Add the current character (operator, variable, etc.)
			tokens.append(char)
	
	# last token if equation ends with number
	if current_token != "":
		tokens.append(current_token)
	
	return tokens

func _equation_template_updated(index: int, button: int, term_text : String):
		match button:
			1:
				#put term from term set into equation template
				if grabbed_term.visible and equation_template.term_slots.get_child(index).term_label.text == "___":
					equation_template.term_slots.get_child(index).set_term_text(grabbed_term.term_label.text)
					grabbed_term.visible = !grabbed_term.visible
				# replace a term with another
				elif grabbed_term.visible and equation_template.term_slots.get_child(index).term_label.text != "___":
					var tmptext = term_text
					equation_template.term_slots.get_child(index).set_term_text(grabbed_term.term_label.text)
					grabbed_term.term_label.text = tmptext
					
				#grab term from equation template 
				elif !grabbed_term.visible and equation_template.term_slots.get_child(index).term_label.text != "___":
					grabbed_term.visible = !grabbed_term.visible
					grabbed_term.term_label.text = term_text
					equation_template.set_term_slot(index, "___")
					
					
		check_equation_correct()
		Utils.update_line.emit(equation_template.get_equation())
				
				
func _on_term_set_updated(index:int, button: int, term_text : String):
	match button:
		1:
			if !grabbed_term.visible and term_set.term_container.get_child(index).term_label.text != "___":
				grabbed_term.visible = !grabbed_term.visible
				grabbed_term.term_label.text = term_text
				term_set.set_term_slot(index, "___")
				#player should not be able to place a term when there is another number in that slot
			elif grabbed_term.visible and term_set.term_container.get_child(index).term_label.text == "___":
				grabbed_term.visible = !grabbed_term.visible
				term_set.set_term_slot(index, grabbed_term.term_label.text)
				

func is_equation_correct() -> bool:
	return equation_template.get_equation() == correct_equation

func check_equation_correct():
	if equation_template.get_equation() == correct_equation:
		equation_is_correct.emit()
		await get_tree().create_timer(3.0).timeout
		new_question()
	elif equation_template.get_empty_term_slots() == 0:
		equation_is_false.emit()

func _on_equation_is_correct():
	Utils.points += 1
	points.text = str(Utils.points)

func set_equation_template(equation: String, num: int) -> void:
	var tokens = tokenize_equation(equation)
	var tmp_string = ""
	
	for token in tokens:
		tmp_string += token
	
	#print(tokens)
	set_correct_equation(tmp_string)
	equation_template.num_term_slots = num 
	equation_template.set_term_slots()
	
func set_term_set(equation: String, num: int) -> void:
	var tokens = tokenize_equation(equation)
	term_set.set_term_set(tokens, num)

func set_correct_equation(string : String):
	correct_equation = string
	print("set_correct_equation in equation_template.gd: ", correct_equation)

func skip_equation():
	if Utils.points <= 1:
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.ROBOTIC_3)
		return
	else:
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_4)
		Utils.points -= 2
		points.text = str(Utils.points)
		new_question()

func set_points():
	points.text = str(Utils.points)
	print("test set_points", " ", Utils.points)

func new_question():
	var question = QuestionBank.random_question()
	set_term_set(question[0], question[1])
	set_equation_template(question[0], question[1])
	print(correct_equation)
	update_equation.emit(question[0])
	
