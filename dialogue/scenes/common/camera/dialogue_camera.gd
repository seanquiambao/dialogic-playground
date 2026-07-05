extends Node3D

var characters: Dictionary[String, Node3D]
func _ready() -> void:
	Dialogic.Text.speaker_updated.connect(_on_speaker_updated)
	var characters_in_scene = get_tree().get_nodes_in_group("characters")
	for scene_character in characters_in_scene:
		var dialogic_character: DialogicCharacter = scene_character.character
		characters[dialogic_character.get_character_name()] = scene_character

func _on_speaker_updated(character: DialogicCharacter):
	position = characters[character.get_character_name()].position
