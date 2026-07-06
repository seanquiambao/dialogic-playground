extends Node3D

class_name DialogueCharacter
@onready var dialogue_camera: Camera3D = $DialogueCamera
@onready var characters: Node = $Characters

@export var timeline: String

var dialogue_character = preload("res://dialogue/scenes/common/character/dialogue_character.tscn")

func _ready() -> void:
	Dialogic.Portraits.character_joined.connect(_on_character_joined)
	Dialogic.start(timeline)

func _on_character_joined(info: Dictionary) -> void:
	var character: DialogicCharacter = info.character

	for character_node in characters.get_children():
		if character_node._character != null:
			continue
		character_node.set_character(character)
		dialogue_camera.register_character(character, character_node)
		break
