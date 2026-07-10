extends DialogicBackground

@onready var dialogue_camera: Camera3D = $DialogueCamera
@onready var characters: Node = $Characters

var timeline: DialogicTimeline

func _ready() -> void:
	Dialogic.Portraits.character_joined.connect(_on_character_joined)

func _on_character_joined(info: Dictionary) -> void:
	var character: DialogicCharacter = info.character
	var is_protagonist: bool = character.description.contains("protagonist")
	for character_node in characters.find_children("*Character*"):
		if is_protagonist:
			continue
		if character_node._character:
			continue

		character_node.set_character(character)
		dialogue_camera.register_character(character, character_node)
		break
