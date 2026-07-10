extends Node3D
@onready var background: Sprite3D = $Background
@onready var character_node: Node3D = $CharacterNode
var background_texture

func _ready() -> void:
	background.texture = background_texture
	Dialogic.Portraits.character_joined.connect(_on_character_joined)

func _on_character_joined(info: Dictionary) -> void:
	var character: DialogicCharacter = info.character
	var is_protagonist: bool = character.description.contains("protagonist")
	if not is_protagonist:
		return
	if character_node._character:
		return

	character_node.set_character(character)
