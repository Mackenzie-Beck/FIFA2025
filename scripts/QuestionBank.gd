extends Node


var questions = {
	"y=x+3": 5,
	"y=2x-5": 6,
	"y=-3x+7": 7,
	"y=4x": 4,
	"y=-x": 4,
	"y=5x+2": 6,
	"y=-2x-8": 7,
	"y=x": 3,
	"y=3x+1": 6,
	"y=-4x+6": 7,
	"y=7x-3": 6,
	"y=-x+9": 7,
	"y=2x": 4,
	"y=-5x": 5,
	"y=x-4": 6,
	"y=6x+8": 6,
	"y=-3x": 5,
	"y=8x-1": 6,
	"y=-2x+10": 7,
	"y=4x-7": 6,
	"y=-6x+3": 7,
	"y=x+12": 6,
	"y=9x": 4,
	"y=-x-5": 7,
	"y=3x-2": 6,
	"y=-7x+4": 7,
	"y=5x-6": 6,
	"y=-4x-1": 7,
	"y=2x+11": 6,
	"y=-8x+2": 7
}



# return a random question:term_num pair from the question_dict
func random_question() -> Array:
	var key = questions.keys().pick_random()
	return [key, questions[key]]
