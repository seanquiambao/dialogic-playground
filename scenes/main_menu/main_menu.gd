extends Control

@export var timelines: Array[DialogicTimeline]
@onready var option_button: OptionButton = $CanvasLayer/VBoxContainer/OptionButton
@onready var error: Label = $CanvasLayer/VBoxContainer/Error
@onready var major_dialogue = preload("res://dialogue/scenes/common/major_dialogue/major_dialogue.tscn")

func _ready() -> void:
	for timeline in timelines:
		var timeline_name: String = timeline.resource_path.split("/")[-1].replace(".dtl", "")
		option_button.add_item(timeline_name);


func _on_button_pressed() -> void:
	var selected_id = option_button.get_selected_id()
	if selected_id == -1:
		error.text = "You have not selected a timeline!"
		return
	var major_dialogue_instance = major_dialogue.instantiate()
	major_dialogue_instance.current_timeline = timelines[selected_id]
	add_child(major_dialogue_instance)
	Dialogic.start(timelines[selected_id])
