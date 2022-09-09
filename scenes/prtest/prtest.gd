extends Node


func _ready() -> void:
    var err := get_viewport().connect("size_changed", self, "_scale_piano_roll")
    assert(err == OK)
    _scale_piano_roll()

func _scale_piano_roll() -> void:
    var roll := get_node("%piano_roll") as PianoRoll
    var screensize = get_viewport().size

    roll.scale.x = screensize.x / roll.size.x
    roll.scale.y = roll.scale.x

    roll.position.y = screensize.y - (roll.size.y * roll.scale.y)
