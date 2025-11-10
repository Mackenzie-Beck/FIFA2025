extends Node


var questions = {
	"y=x+3": 5,
	"y=2*x-5": 6,
	"y=-3*x+7": 7,
	"y=4*x": 4,
	"y=-x": 4,
	"y=5*x+2": 6,
	"y=-2*x-8": 7,
	"y=x": 3,
	"y=3*x+1": 6,
	"y=-4*x+6": 7,
	"y=7*x-3": 6,
	"y=-x+9": 7,
	"y=2*x": 4,
	"y=-5*x": 5,
	"y=x-4": 6,
	"y=6*x+8": 6,
	"y=-3*x": 5,
	"y=8*x-1": 6,
	"y=-2*x+10": 7,
	"y=4*x-7": 6,
	"y=-6*x+3": 7,
	"y=x+12": 6,
	"y=9*x": 4,
	"y=-x-5": 7,
	"y=3*x-2": 6,
	"y=-7*x+4": 7,
	"y=5*x-6": 6,
	"y=-4*x-1": 7,
	"y=2*x+11": 6,
	"y=-8*x+2": 7
}



# return a random question:term_num pair from the question_dict
func random_question() -> Array:
	var key = questions.keys().pick_random()
	return [key, questions[key]]
