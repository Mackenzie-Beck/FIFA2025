extends Node


var questions = {
"y=x+3" : 5,
"y=2*x-5":	7,
"y=-3*x+7":	8,
"y=4*x+0"	:7,
"y=-x+2":6,
"y=5*x+2":	7,
"y=-x-8":	8,
"y=x+1" :5,
"y=3*x+4" :7

}

# return a random question:term_num pair from the question_dict
func random_question() -> Array:
	var key = questions.keys().pick_random()
	return [key, questions[key]]

# Load questions from a CSV file
func load_questions_from_csv(file_path: String, replace: bool = true) -> bool:
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
