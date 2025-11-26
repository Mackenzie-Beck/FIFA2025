extends Node2D

@onready var object_layer: TileMapLayer = $ObjectLayer


func _ready() -> void:
	# connect signals
	UI_control.term_interface.update_equation.connect(object_layer._on_update_equation)
	
	QuestionBank.load_questions_from_csv("res://data/test_data.txt", true)
	
	
	
	
	var question = QuestionBank.random_question()
	UI_control.term_interface.set_term_set(question[0], question[1])
	UI_control.term_interface.set_equation_template(question[0], question[1])
	object_layer.initialize_game_world(question[0])
