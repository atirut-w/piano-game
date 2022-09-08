extends Node


func _ready() -> void:
	OS.open_midi_inputs()
	print("MIDI input initialized")

	var menu = yield(load_resource_async("res://scenes/miditest/miditest.tscn"), "completed")
	var err := get_tree().change_scene_to(menu)
	assert(err == OK)


func load_resource_async(path: String, type_hint: String = "") -> Resource:
	var loader := ResourceLoader.load_interactive(path, type_hint)
	var stage_count := loader.get_stage_count()

	for n in stage_count + 1: # TODO: This looks sketchy as hell
		var err := loader.poll()
		assert(err == OK or err == ERR_FILE_EOF)
		yield(get_tree(), "idle_frame")

	return loader.get_resource()
