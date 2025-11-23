extends Node


var questions = {

}

# return a random question:term_num pair from the question_dict
func random_question() -> Array:
	var key = questions.keys().pick_random()
	return [key, questions[key]]

# Load questions from a CSV file
func load_questions_from_csv(file_path: String, replace: bool = false) -> bool:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: " + file_path)
		return false
	
	# Clear existing questions if replace flag is true
	if replace:
		questions.clear()
	
	# Skip header line if your CSV has one
	if not file.eof_reached():
		file.get_line()
	
	# Read each line and add to questions dictionary
	while not file.eof_reached():
		var line = file.get_line()
		if line.strip_edges() == "":
			continue
		
		var parts = line.split(",")
		if parts.size() >= 2:
			var equation = parts[0].strip_edges()
			var term_count = int(parts[1].strip_edges())
			questions[equation] = term_count
	
	file.close()
	return true
