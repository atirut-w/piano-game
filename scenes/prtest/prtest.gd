extends Node


func _ready() -> void:
    var roll := get_node("%piano_roll") as PianoRoll
    var screensize = get_viewport().size

    roll.scale.x *= screensize.x / roll.size.x
    roll.scale.y = roll.scale.x

    roll.position.y = screensize.y - (roll.size.y * roll.scale.y)
