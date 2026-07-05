extends Node3D

@onready var sprite_3d: Sprite3D = $Sprite3D

@export var character: DialogicCharacter

var _portraits: Dictionary = {}
func _ready() -> void:
	Dialogic.Text.about_to_show_text.connect(_on_about_to_show_text)
	var portraits_info = character.portraits
	for key in portraits_info.keys():
		var image_path = portraits_info[key]["export_overrides"]["image"].replace("\"", "")
		if ResourceLoader.exists(image_path):
			var image_texture = ResourceLoader.load(image_path)
			_portraits[key] = image_texture
	sprite_3d.texture = _portraits["neutral"]

func _on_about_to_show_text(info: Dictionary) -> void:
	var portrait_name: String = info.portrait
	if _portraits.has(portrait_name):
		sprite_3d.texture = _portraits[portrait_name]
