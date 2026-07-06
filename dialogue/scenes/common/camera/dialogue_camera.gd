extends Node3D

var characters: Dictionary[String, Node3D]

var _target_position: Vector3
var _current_position: Vector3

func _ready() -> void:
	Dialogic.Text.speaker_updated.connect(_on_speaker_updated)

func register_character(character: DialogicCharacter, scene_character: Node3D) -> void:
	var character_name: String = character.get_character_name()
	characters.set(character_name, scene_character)

func _process(delta: float) -> void:
	var new_position = _current_position.move_toward(_target_position, 0.5)
	position = new_position
	_current_position = new_position

func _on_speaker_updated(character: DialogicCharacter):
	if not character:
		return
	_target_position = characters[character.get_character_name()].position + Vector3(0, 1, 2)
