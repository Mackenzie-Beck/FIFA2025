extends Node



const GAME = preload("res://game.tscn")





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI_control.main_menu.start_game.connect(_on_start_game)


func _on_start_game():
	if QuestionBank.questions.is_empty():
		return
	
	for child in get_children():
		child.queue_free()
	
	# Wait for the next frame so children are actually removed
	await get_tree().process_frame

	
	var new_game = GAME.instantiate()
	add_child(new_game)
	UI_control.toggle_term_interface()
