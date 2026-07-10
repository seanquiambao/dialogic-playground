extends Control
@onready var character_subviewport: SubViewport = $CharacterContainer/CharacterSubviewport
@onready var protagonist_subviewport: SubViewport = $ProtagonistContainer/ProtagonistSubviewport
@onready var protagonist_scene = preload("res://dialogue/scenes/common/characters/protagonist_character.tscn")

var current_timeline: DialogicTimeline

var character_scene_instance
var protagonist_scene_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.Backgrounds.background_changed.connect(_on_background_changed)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended() -> void:
	character_subviewport.remove_child(character_scene_instance)
	protagonist_subviewport.remove_child(protagonist_scene_instance)
	protagonist_scene_instance.queue_free()
	character_scene_instance.queue_free()
	current_timeline = null
	queue_free()

func setup_character_view(info: Dictionary) -> void:
	var scene: PackedScene = load(info.scene)
	character_subviewport.add_child(character_scene_instance)
	character_scene_instance = scene.instantiate()
	character_scene_instance.timeline = current_timeline
	character_subviewport.add_child(character_scene_instance)

func setup_protagonist_view(info: Dictionary) -> void:
	var image_path = info.argument
	if not image_path:
		return
	if not ResourceLoader.exists(image_path):
		return
	var image_texture = ResourceLoader.load(image_path)
	protagonist_scene_instance = protagonist_scene.instantiate()
	protagonist_scene_instance.background_texture = image_texture
	protagonist_subviewport.add_child(protagonist_scene_instance)

func _on_background_changed(info: Dictionary) -> void:
	if not info.scene:
		return
	
	setup_character_view(info)
	setup_protagonist_view(info)
