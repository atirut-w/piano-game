extends Node2D


export(Texture) var black_key
export(Texture) var white_key

const black_keys := {
	1: true,
	4: true,
	6: true,
	9: true,
	11: true,
}


func _ready() -> void:
	var key_width := int(black_key.get_size().x)
	var next_position := 0
	scale = Vector2(2, 2)

	for i in 88:
		var spr := Sprite.new()
		spr.centered = false
		spr.position.x = next_position
		var note := int(i % 12)

		if note in black_keys:
			spr.texture = black_key
			spr.position.x -= float(key_width) / 2
			spr.z_index += 1
		else:
			spr.texture = white_key
			next_position += key_width

		add_child(spr)


func _input(event: InputEvent) -> void:
	if event is InputEventMIDI:
		if event.message == MIDI_MESSAGE_NOTE_ON:
			var octave := float(event.pitch / 12)
			var note := float(event.pitch % 12)
			print("%d, %d" % [note, octave])
