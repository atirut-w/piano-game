extends Node2D


export(Texture) var black_key_off
export(Texture) var black_key_on
export(Texture) var white_key_off
export(Texture) var white_key_on

var piano_width: int
var keys := []

const black_keys := {
	1: true,
	4: true,
	6: true,
	9: true,
	11: true,
}


func _ready() -> void:
	var key_width := int(black_key_off.get_size().x)
	var next_position := 0
	scale = Vector2(2, 2)

	for i in 88:
		var spr := Sprite.new()
		spr.centered = false
		spr.position.x = next_position
		var note := int(i % 12)

		if note in black_keys:
			spr.texture = black_key_off
			spr.position.x -= float(key_width) / 2 # TODO: Account for different key width
			spr.z_index += 1
		else:
			spr.texture = white_key_off
			next_position += key_width

		add_child(spr)
		keys.append(spr)

	piano_width = next_position # TODO: Subtract by 1 or no?


func _input(event: InputEvent) -> void:
	if event is InputEventMIDI:
		var note := int(event.pitch - 21)

		if event.message == MIDI_MESSAGE_NOTE_ON:
			if note % 12 in black_keys:
				keys[note].texture = black_key_on
			else:
				keys[note].texture = white_key_on
		elif event.message == MIDI_MESSAGE_NOTE_OFF:
			if note % 12 in black_keys:
				keys[note].texture = black_key_off
			else:
				keys[note].texture = white_key_off
