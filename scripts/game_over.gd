extends Control

@onready var score = $score
@onready var pause = get_tree()

func _process(delta):
    score.text = "Score: " + str(global.score)

func _on_retry_pressed():
    pause.paused = true

    get_tree().change_scene_to_file("res://scenes/levels/level"+str(global.current_level)+".tscn")
    pause.paused = false

func _on_main_menu_pressed():
    pause.paused = true
    get_tree().change_scene_to_file("res://scenes/menu.tscn")
    pause.paused = false
    print(pause.paused)




func _on_quit_pressed():
    get_tree().quit()
    
