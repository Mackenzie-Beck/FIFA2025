extends Node


var questions = {
	"y=x+13": 5,
	"y=2*x-15": 7,
	"y=-3*x+17": 8,
	"y=4*x+10": 7,
	"y=-x+12": 6,
	"y=5*x+22": 7,
	"y=-2*x-18": 8,
	"y=x+11": 5,
	"y=3*x+14": 7,
	"y=-4*x+16": 8,
	"y=7*x-13": 7,
	"y=-x+19": 6,
	"y=2*x+20": 7,
	"y=-5*x+15": 8,
	"y=x-14": 5,
	"y=6*x+18": 7,
	"y=-3*x+21": 8,
	"y=8*x-11": 7,
	"y=-2*x+10": 8,
	"y=4*x-17": 7,
	"y=-6*x+23": 8,
	"y=x+12": 5,
	"y=9*x-15": 7,
	"y=-x-15": 6,
	"y=3*x-12": 7,
	"y=-7*x+14": 8,
	"y=5*x-16": 7,
	"y=-4*x-11": 8,
	"y=2*x+11": 7,
	"y=-8*x+22": 8
}

# return a random question:term_num pair from the question_dict
func random_question() -> Array:
	var key = questions.keys().pick_random()
	return [key, questions[key]]
