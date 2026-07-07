extends Node3D

class_name DialogueCharacter
@onready var dialogue_camera: Camera3D = $DialogueCamera
@onready var characters: Node = $Characters

@export var timeline: String

func _ready() -> void:
	Dialogic.Portraits.character_joined.connect(_on_character_joined)
	Dialogic.start(timeline)

func _on_character_joined(info: Dictionary) -> void:
	var character: DialogicCharacter = info.character
	var is_protagonist: bool = character.description.contains("protagonist")
	for character_node in characters.find_children("*Character*"):
		if is_protagonist and not character_node.is_protagonist:
			continue
		if character_node._character:
			continue

		character_node.set_character(character)
		dialogue_camera.register_character(character, character_node)
		break
