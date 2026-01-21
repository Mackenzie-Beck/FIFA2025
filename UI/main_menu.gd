extends Control







signal start_game

func _ready() -> void:
	Utils.play_music()


func open_file_picker():
	var file_dialog = FileDialog.new()
	add_child(file_dialog)
	
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.filters = ["*.csv ; CSV Files"]
	file_dialog.current_dir = "res://data/"
	
	file_dialog.file_selected.connect(_on_file_selected)
	file_dialog.canceled.connect(func(): file_dialog.queue_free())
	
	file_dialog.popup_centered_ratio(0.8)

func _on_file_selected(path: String):
	print("Selected: ", path)
	QuestionBank.load_questions_from_csv(path, true)


func _on_load_csv_button_down() -> void:
	open_file_picker()


func _on_play_button_down() -> void:
	start_game.emit()
