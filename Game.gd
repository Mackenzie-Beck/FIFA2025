extends Node2D


@onready var term_interface: Control = $UiControl/term_interface


func _ready() -> void:
	var question = QuestionBank.random_question()
	term_interface.set_term_set(question[0], question[1])
	term_interface.set_equation_template(question[1])
