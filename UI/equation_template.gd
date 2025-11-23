extends PanelContainer
class_name EquationTemplate

const TERM = preload("uid://c3lam4sdf8qcb")

@onready var term_slots: HBoxContainer = $VBoxContainer/MarginContainer/term_slots
@onready var correct_label: Label = $VBoxContainer/correct_label


signal equation_template_updated(index: int, button: int, term_text : String)
signal skip_current_equation

var num_term_slots: int = 0





func _ready() -> void:
	for i in num_term_slots:
		var new_term = TERM.instantiate()
		new_term.set_term_text("___")
		term_slots.add_child(new_term)
		new_term.term_clicked.connect(_on_term_clicked)
		

func _on_term_clicked(index : int, button: int, term_text : String) -> void:
	equation_template_updated.emit(index, button, term_text)

func _on_equation_is_correct():
	correct_label.text = "Correct!"
	correct_label.show()
	await get_tree().create_timer(3.0).timeout
	correct_label.hide()
	
func _on_equation_is_false():
	correct_label.text = "Wrong!"
	correct_label.show()
	await get_tree().create_timer(3.0).timeout
	correct_label.hide()

func set_term_slots() -> void:
	clear_term_slots()
	for i in num_term_slots:
		var new_term = TERM.instantiate()
		new_term.set_term_text("___")
		term_slots.add_child(new_term)
		new_term.term_clicked.connect(_on_term_clicked)

func set_term_slot(index : int, term_text: String) -> void:
	term_slots.get_child(index).set_term_text(term_text)
	
func get_equation() -> String:
	var equation : String
	
	for term in term_slots.get_children():
		equation = equation + term.get_term_text()
	
	return equation

func get_empty_term_slots() -> int:
	var tmp_int = 0
	for term in term_slots.get_children():
		if term.get_term_text() == "___":
			tmp_int += 1
			
	return tmp_int


func clear_term_slots():
	for term in term_slots.get_children():
		term.queue_free()
		
func _on_skip_button_button_down() -> void:
	skip_current_equation.emit()
