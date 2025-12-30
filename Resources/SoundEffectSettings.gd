class_name SoundEffect 
extends Resource
## Sound effect resource, used to configure unique sound effects for use with the AudioManager. Passed to [method AudioManager.create_2d_audio_at_location()] and [method AudioManager.create_audio()] to play sound effects.

## Stores the different types of sounds effects available to be played to distinguish them from another. Each new SoundEffect resource created should add to this enum, to allow them to be easily instantiated via [method AudioManager.create_2d_audio_at_location()] and [method AudioManager.create_audio()].
enum SOUND_EFFECT_TYPE {
	UI_BUTTON_1,
	UI_BUTTON_2,
	UI_BUTTON_3,
	UI_BUTTON_4,
	UI_ACTIVATE_1,
	UI_ACTIVATE_2,
	UI_ACTIVATE_3,
	UI_CONSOLE_1,
	UI_CONSOLE_2,
	UI_CONSOLE_3,
	UI_CONSOLE_4,
	UI_CONSOLE_5,
	CONSOLE_1,
	CONSOLE_2,
	CPU_1,
	CPU_2,
	CPU_3,
	CPU_4,
	CPU_5,
	ROBOT_1,
	ROBOT_2,
	ROBOTIC_1,
	ROBOTIC_2,
	ROBOTIC_3,
	ROBOTIC_4,
	ROBOTIC_5,
	BLACK_HOLE,
	COSMOS,
	ENCOUNTER,
	HOME,
	METEOR,
	NEBULA,
	THE_BEGINNING,
	THE_END,
	THE_SUN,
	THE_VOID
}

@export_range(0, 10) var limit: int = 5 ## Maximum number of this SoundEffect to play simultaneously before culled.
@export var type: SOUND_EFFECT_TYPE ## The unique sound effect in the [enum SOUND_EFFECT_TYPE] to associate with this effect. Each SoundEffect resource should have it's own unique [enum SOUND_EFFECT_TYPE] setting.
@export var sound_effect: AudioStreamOggVorbis ## The [AudioStreamOggVorbis] audio resource to play.
@export_range(-40, 20) var volume: float = 0 ## The volume of the [member sound_effect].
@export_range(0.0, 4.0,.01) var pitch_scale: float = 1.0 ## The pitch scale of the [member sound_effect].
@export_range(0.0, 1.0,.01) var pitch_randomness: float = 0.0 ## The pitch randomness setting of the [member sound_effect].

var audio_count: int = 0 ## The instances of this [AudioStreamOggVorbis] currently playing.


## Takes [param amount] to change the [member audio_count]. 
func change_audio_count(amount: int) -> void:
	audio_count = max(0, audio_count + amount)


## Checkes whether the audio limit is reached. Returns true if the [member audio_count] is less than the [member limit].
func has_open_limit() -> bool:
	return audio_count < limit


## Connected to the [member sound_effect]'s finished signal to decrement the [member audio_count].
func on_audio_finished() -> void:
	change_audio_count(-1)
