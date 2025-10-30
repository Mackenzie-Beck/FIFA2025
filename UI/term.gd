extends PanelContainer
class_name Term


@onready var term_label: Label = $MarginContainer/Label



signal term_clicked(index : int, button: int, term_text : String) 
# signal to emit when this term is clicked, inlcude the button mask to allow for right clicks (not sure what purpose)


func _on_gui_input(event):
	if event is InputEventMouseButton \
	and (event.button_index == MOUSE_BUTTON_LEFT\
	or event.button_index == MOUSE_BUTTON_RIGHT)\
	and event.is_pressed():
		term_clicked.emit(get_index(), event.button_index, term_label.text)


func set_term_text(text : String) -> void:
	if term_label:
		term_label.text = text
	else:
		# If called before ready, defer the assignment
		await ready
		term_label.text = text
