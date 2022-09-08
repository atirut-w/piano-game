extends Node


func _input(event: InputEvent) -> void:
	if event is InputEventMIDI:
		if event.message == MIDI_MESSAGE_NOTE_ON:
			print("Note #%d on" % event.pitch)
