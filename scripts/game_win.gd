extends Control

@onready var score = $score
@onready var retry = $buttons2/retry
@onready var http = $HTTPRequest
@onready var status = $status
@onready var pause = get_tree()
@onready var buttons = $buttons2

var buttons_disabled = true
var leaderboard_level = false
@onready var current_level = ""

var url = "https://up-from-the-lava-from-as-lebro-default-rtdb.asia-southeast1.firebasedatabase.app"
var method = HTTPClient.METHOD_POST

func _process(delta):
    current_level = get_tree().current_scene.scene_file_path.split("/")[-1].split(".")[0]
    if current_level == "level1":
        leaderboard_level = true
        buttons_disabled  = true
    else:
        leaderboard_level = false
        buttons_disabled = false
    # print(current_level+": leaderboard_level = " + leaderboard_level + ", buttons_disabled = " + buttons_disabled)

func _ready():
    current_level = get_tree().current_scene.scene_file_path.split("/")[-1].split(".")[0]



    score.text = "Score: " + str(global.score)

        
func _on_retry_pressed():
    pause.paused = true
    get_tree().change_scene_to_file("res://scenes/levels/level"+str(global.current_level)+".tscn")
    pause.paused = false

func _on_main_menu_pressed():
    get_tree().change_scene_to_file("res://scenes/menu.tscn")
    pause.paused = false

func _on_quit_pressed():
    get_tree().quit()
    
func _on_http_request_request_completed(result, response_code, headers, body):
    print(result, response_code, headers, body.get_string_from_utf8())
    print("/\\ is the")
    status.text = "saved " + str(global.score) + " as " + str(global.local_name) + "."
    
    if buttons_disabled == true: 
        for btn in buttons.get_children():
            btn.disabled = false


func _on_finish_line_body_entered(body):
    if leaderboard_level == false:
        status.text = current_level + ": not supported leaderboard level!"
    else:
        status.text = "saving to servers..."

    if buttons_disabled == true: 
        for btn in buttons.get_children():
            btn.disabled = true
    
    if current_level == "level1":
        print("sadf"+current_level)

        var score = (Time.get_ticks_msec() - global.global_start_time)
        var unix = Time.get_unix_time_from_system()

        # var data = PackedStringArray(['{"data":{"time":' + str(unix) + ', "score": ' + str(score) + '}}'])
        # var data = {"data":{"time": + str(unix) + ',' "score":  + str(score) + }}
        var data = {"data":{"time": str(unix), "score": str(score)}}
        var data_string = HTTPClient.new().query_string_from_dict(data)
        var data_arr = PackedStringArray([str(data_string)])
        var headers = PackedStringArray(['"Content-Type: application/json", "Content-Length: " + str(data_string.length())'])

        var request = url + "/scores/" + str(global.local_name) + ".json"
        print(request)
        # var http = HTTPClient.new()
    
        # http.request_completed.connect(_on_http_request_completed)
        var resp = http.request(request, data_arr, method)
        print(resp)

        # var result = http.request(http.METHOD_PATCH, request, headers, data_string)

func _on_next_level_pressed():
    pause.paused = true
    global.current_level += 1 
    if FileAccess.file_exists("res://scenes/levels/level"+str(global.current_level)+".tscn"):
        get_tree().change_scene_to_file("res://scenes/levels/level"+str(global.current_level)+".tscn")
    
        pause.paused = false
    else:
        get_tree().change_scene_to_file("res://scenes/menu.tscn")
        pause.paused = false




# func _on_http_request_request_completed(result, response_code, headers, body):
#     pass # Replace with function body.
