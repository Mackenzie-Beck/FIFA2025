extends Node2D


@onready var term_interface: Control = $UiControl/term_interface


func _ready() -> void:
	term_interface.set_number_of_terms(QuestionBank.random_question()[1])
