extends Node

# Global Variables
var points : int = 0


var rng = RandomNumberGenerator.new()

signal update_line(equation : String)



func play_music():
	var tmp = rng.randi_range(26,34)
	AudioManager.create_audio(tmp)
