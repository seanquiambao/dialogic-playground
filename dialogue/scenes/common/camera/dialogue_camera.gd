extends Node3D

var characters: Dictionary[String, Node3D]

var _current_position: Vector3
var _target_position: Vector3 = _current_position

const OFFSET: Vector3 =  Vector3(0, 1, 2)
const CAMERA_PAN_TIME: float = 0.25

func _ready() -> void:
	Dialogic.Text.speaker_updated.connect(_on_speaker_updated)

func register_character(character: DialogicCharacter, scene_character: Node3D) -> void:
	var character_name: String = character.get_character_name()
	characters.set(character_name, scene_character)
	var current_timeline: DialogicTimeline = Dialogic.current_timeline
	for event in current_timeline.events:
		if event is DialogicTextEvent:
			if event.character.get_character_name() == character_name:
				position = scene_character.position + OFFSET
				_current_position = position
			break

func _process(delta: float) -> void:
	var new_position = _current_position.move_toward(_target_position, CAMERA_PAN_TIME)
	position = new_position
	_current_position = new_position

func _on_speaker_updated(character: DialogicCharacter):
	if not character:
		return
	_target_position = characters[character.get_character_name()].position + OFFSET
