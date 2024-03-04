extends Node2D

@onready var timer = $ui/timer
@onready var game_over_screen = $ui/game_over
@onready var game_win_screen = $ui/game_win
@onready var death = $sound/death



func _on_lava_body_entered(body):
    if body.name == "player":
        game_over()

func _on_spike_body_entered(body):
    if body.name == "player":
        game_over()

func game_over():
#    global.score = timer.text
    death.play(0.0)
    global.score = timer.get_child(0).text
    game_over_screen.visible = true
    get_tree().paused = true
    timer.visible = false
    

func game_win():
    pass
    
func restart():
    get_tree().change_scene_to_file(get_level())

func get_level():
    return "res://scenes/levels/level" + str(global.current_level) + ".tscn"

func _process(delta):
    if Input.is_action_pressed("restart"):
        restart()

func _on_finish_line_body_entered(body):
    global.score = timer.get_child(0).text
    game_win_screen.visible = true
    get_tree().paused = true
    timer.visible = false
