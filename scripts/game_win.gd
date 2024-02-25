extends Control

@onready var score = $score
@onready var retry = $buttons2/retry
@onready var http = $http
@onready var status = $status
@onready var pause = get_tree()
@onready var buttons = $buttons2

var buttons_disabled = true

var url = "http://dreamlo.com/lb/cDBT1v2pkEC_cuoZy7-BzQEO5o81ms5kanfKzY2LKYdQ"
var method = HTTPClient.METHOD_GET



func _ready():
    if get_tree().current_scene.name == "level1":

        score.text = "unsupported leaderboard level!"
    else: 
        score.text = "Score: " + str(global.score)
        for btn in buttons.get_children():
            btn.disabled = true

func _on_retry_pressed():
    pause.paused = true
    get_tree().change_scene_to_file("res://scenes/levels/level"+str(global.current_level)+".tscn")
    pause.paused = false

func _on_main_menu_pressed():
    get_tree().change_scene_to_file("res://scenes/menu.tscn")
    pause.paused = false

func _on_quit_pressed():
    get_tree().quit()
    
func _on_http_request_completed(result, response_code, headers, body):
    print(result, response_code, headers, body.get_string_from_utf8())
    status.text = "saved " + str(global.score) + " as " + str(global.local_name) + "."
    


func _on_finish_line_body_entered(body):
    var score = (Time.get_ticks_msec() - global.global_start_time)
    var request = url + "/add/" + str(global.local_name) + "/" + str(score)
    print(request)
    if get_tree().current_scene.name == "level1":
        http.request(request, PackedStringArray(), method)


func _on_next_level_pressed():
    pause.paused = true
    global.current_level += 1 
    if FileAccess.file_exists("res://scenes/levels/level"+str(global.current_level)+".tscn"):
        get_tree().change_scene_to_file("res://scenes/levels/level"+str(global.current_level)+".tscn")
    
        pause.paused = false
    else:
        get_tree().change_scene_to_file("res://scenes/menu.tscn")
        pause.paused = false


