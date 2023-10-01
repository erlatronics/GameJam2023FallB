extends Control

@onready var fade = $Fade
@onready var image = $Image

# Called when the node enters the scene tree for the first time.
func _ready():
	State.set_bg_image.connect(set_bg_image)
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_callback(start_dialog)

func start_dialog():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_example_dialogue_balloon(load("res://Dialog/betrayal.dialogue"), "alleyway")

func _on_dialogue_ended(_resource: DialogueResource):
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "modulate", Color(1, 1, 1, 1), 1)
	# TODO: Check state, where should we go?
	tween.tween_callback(goto_mansion)
	
func goto_mansion():
	if State.ran_away:
		get_tree().quit()
	else:
		get_tree().change_scene_to_file("res://Scenes/MansionCutscene.tscn")

func set_bg_image(texture: Texture2D):
	image.set_texture(texture)
