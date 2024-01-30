extends Control

@onready var title_splash = $title/title_splash
@onready var animation_player = $title/title_splash/AnimationPlayer
@onready var reloaded_title_splash = $title/reloaded_splash
@onready var reloaded_animation_player = $title/reloaded_splash/AnimationPlayer
@onready var audio = $AudioStreamPlayer2D
var volume
@onready var background_colour = $background_colour
@onready var version = $version
@onready var settings_animation_player = $settings/AnimationPlayer
@onready var settings = $settings
@onready var settings_button = $buttons/settings
@onready var tab_container = $TabContainer



func _ready():
#	audio.play(7)
	audio.play()
	version.text = "Version: " + str(global.version)
	# tab_container.set_tab_disabled(2, true)


func _process(delta):
	animation_player.play("tilting")
	reloaded_animation_player.play("tilting")
	await animation_player.animation_finished
	volume = AudioServer.get_bus_volume_db(0)
	print(volume)
func _on_audio_finished():
#	audio.play(7)
	audio.play()

func _on_play_pressed():
	var tween = create_tween().set_parallel(true)
	var count := 0
	var transition_time = 2
	
	for child in get_children():
		if child.name == background_colour.name:
			count += 1
		else:	
			tween.tween_property(child, "modulate", Color(0,0,0,0), transition_time)
			tween.tween_property(audio, "volume_db", -10, transition_time)
			count += 1
			
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/levels/level" + str(global.current_level) + ".tscn")

func _on_download_pressed():
	OS.shell_open("https://github.com/Cashigtro/Up-from-the-Lava-From-as-Lebron")




func _on_version_pressed():
	global.debug_mode = true




func _on_settings_toggled(button_pressed):
	var tween = create_tween()
	if button_pressed:
		settings_button.disabled = true
		settings_animation_player.play("move_in")
		await settings_animation_player.animation_finished
		settings_button.disabled = false
#		tween.tween_property(settings, "position", settings.position + Vector2(1175, 0), 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
#		if !button_pressed:
#			tween.kill()
	if !button_pressed:
		settings_button.disabled = true
		settings_animation_player.play("move_out")
		await settings_animation_player.animation_finished
		settings_button.disabled = false
#		tween.tween_property(settings, "position", settings.position + Vector2(800, 0), 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
#		if button_pressed:
#			tween.kill()!
		


func _on_editor_pressed():
	var tween = create_tween().set_parallel(true)
	var count := 0
	var transition_time = 2
	
	for child in get_children():
		if child.name == background_colour.name:
			count += 1
		else:	
			tween.tween_property(child, "modulate", Color(0,0,0,0), transition_time)
			tween.tween_property(audio, "volume_db", -10, transition_time)
			count += 1
			
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/levels/level" + str(global.current_level) + ".tscn")
