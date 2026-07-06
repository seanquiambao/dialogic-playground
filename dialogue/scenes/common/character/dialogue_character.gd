extends Node3D

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _character: DialogicCharacter

var _portraits: Dictionary = {}

func set_character(new_character: DialogicCharacter) -> void:
	_character = new_character
	var portraits_info = _character.portraits
	for key in portraits_info.keys():
		var image_path = portraits_info[key]["export_overrides"]["image"].replace("\"", "")
		if ResourceLoader.exists(image_path):
			var image_texture = ResourceLoader.load(image_path)
			_portraits[key] = image_texture
	sprite_3d.texture = _portraits["neutral"]
	sprite_3d.visible = true

func _ready() -> void:
	sprite_3d.visible = false
	Dialogic.Text.about_to_show_text.connect(_on_about_to_show_text)
	Dialogic.Portraits.character_left.connect(_on_character_left)

func _on_about_to_show_text(info: Dictionary) -> void:
	var portrait_name: String = info.portrait
	if _portraits.has(portrait_name):
		sprite_3d.texture = _portraits[portrait_name]

func _on_character_left(info: Dictionary):
	if not _character:
		return
	if(info.character.get_character_name() != _character.get_character_name()):
		return
	animation_player.play("fade_out")
