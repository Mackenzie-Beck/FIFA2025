extends PanelContainer
class_name Term


@onready var label: Label = $MarginContainer/Label


signal term_clicked(button: int) 
# signal to emit when this term is clicked, inlcude the button mask to allow for right clicks (not sure what purpose)


func _on_gui_input(event):
	if event is InputEventMouseButton \
	and (event.button_index == MOUSE_BUTTON_LEFT\
	or event.button_index == MOUSE_BUTTON_RIGHT)\
	and event.is_pressed():
		term_clicked.emit(event.button_index)
