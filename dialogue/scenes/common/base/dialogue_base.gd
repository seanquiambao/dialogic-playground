extends Node3D

@export var timeline: String

func _ready() -> void:
	Dialogic.start(timeline)
