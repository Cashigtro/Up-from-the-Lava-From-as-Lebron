extends Control

@onready var music_checkbox = $settings_box/music/music_checkbox
@onready var audio = $"../AudioStreamPlayer2D"

# Called when the node enters the scene tree for the first time.
func _ready():
    music_checkbox.connect("toggled", music_off)


func music_off(button_pressed):
    if !button_pressed:
        audio.stop()
    if button_pressed:
        audio.play()


func _on_iggames_pressed():
        OS.shell_open("https://www.youtube.com/@Cashigrtro")




func _on_h_slider_drag_ended(value_changed):
    get_tree().reload_current_scene()
    ProjectSettings.set_setting("display/window/stretch/scale", value_changed)
