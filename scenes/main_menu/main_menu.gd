extends Control

@export var timelines: Array[DialogicTimeline]
@onready var option_button: OptionButton = $CanvasLayer/VBoxContainer/OptionButton
@onready var error: Label = $CanvasLayer/VBoxContainer/Error
@onready var sub_viewport: SubViewport = %SubViewport

var current_viewport_instance
var current_timeline: DialogicTimeline
func _ready() -> void:
	for timeline in timelines:
		var timeline_name: String = timeline.resource_path.split("/")[-1].replace(".dtl", "")
		option_button.add_item(timeline_name);
	Dialogic.Backgrounds.background_changed.connect(_on_background_changed)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_button_pressed() -> void:
	var selected_id = option_button.get_selected_id()
	if selected_id == -1:
		error.text = "You have not selected a timeline!"
		return
	current_timeline = timelines[selected_id]
	Dialogic.start(timelines[selected_id])

func _on_timeline_ended() -> void:
	sub_viewport.remove_child(current_viewport_instance)
	current_viewport_instance.queue_free()
	current_timeline = null

func _on_background_changed(info: Dictionary) -> void:
	if not info.scene:
		return
	var scene: PackedScene = await load(info.scene)
	current_viewport_instance = scene.instantiate()
	current_viewport_instance.timeline = current_timeline
	sub_viewport.add_child(current_viewport_instance)
