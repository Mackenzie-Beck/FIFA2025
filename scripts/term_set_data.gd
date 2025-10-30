extends Node
class_name TermSet


signal term_set_updated(term_set : TermSet)
signal term_set_interact(term_set: TermSet, index: int, button: int)

@export var term_datas: Array[TermData]



func drop_term_data(grabbed_term_data: TermData, index: int) -> TermData:
	var term_data = term_datas[index]
	
	var return_term_data: TermData
	
	term_datas[index] = grabbed_term_data
	return_term_data = term_data
		
	term_set_updated.emit(self)
	return return_term_data

func grab_term_data(index: int) -> TermData:
	var term_data = term_datas[index]
	
	if term_data:
		term_datas[index] = null
		term_set_updated.emit(self)
		return term_data
	else:
		return null

func on_term_clicked(index: int, button: int) -> void:
	term_set_interact.emit(self, index, button)
