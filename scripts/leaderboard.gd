extends HTTPRequest

@onready var people = $"../people"
var url = "http://dreamlo.com/lb/cDBT1v2pkEC_cuoZy7-BzQEO5o81ms5kanfKzY2LKYdQ"
var leaderboard
var method = HTTPClient.METHOD_GET
var arrow = preload("res://assets/images/arrow_right.png")
var rank: int
var player_name: String
@onready var error = $"../people/Label"

signal more_info_button_pressed(rank, player_name)

func _ready():
    connect("request_completed", populate_leaderboard)
    request(url + "/json-seconds", PackedStringArray(), method)
    
func clear_scores():
    for i in people.get_children():
        i.queue_free()

func get_time(msec_time):
    var current_time = msec_time
    var minutes = int(current_time / 60000)  # 60000 milliseconds in a minute
    var seconds = int((current_time % 60000) / 1000)  # Calculate remaining seconds
    var milliseconds = int(current_time % 1000)  # Calculate milliseconds
    if minutes < 10:
        minutes = "0"+str(minutes)
            
    if seconds < 10:
        seconds = "0"+str(seconds)
    
    if milliseconds:
        if len(str(milliseconds)) <= 2:
            milliseconds = "0"+str(milliseconds)
            
        elif len(str(milliseconds)) <= 1:
            milliseconds = "0"+str(milliseconds)        
    
        
        elif len(str(milliseconds)) <= 0:
            milliseconds = "000"+str(milliseconds)        
    

    return str(minutes) + ":" + str(seconds) + "." + str(milliseconds)

func populate_leaderboard(result, response_code, header, body):
    
    if body:
        var leaderboard = JSON.parse_string(body.get_string_from_utf8())
        print(leaderboard)
        if leaderboard["dreamlo"]["leaderboard"] != null:
            print(len(leaderboard["dreamlo"]["leaderboard"]["entry"]))
            if len(leaderboard["dreamlo"]["leaderboard"]["entry"]) != 1:
                print(leaderboard)
                var leaderboard_objects = leaderboard["dreamlo"]["leaderboard"]["entry"]
                print(leaderboard_objects)
                
                clear_scores()
                
                var count = 0
                for i in leaderboard_objects:
                    var label = Label.new()
                    label.text = (str(count+1) + "# " + i['name'] + ": " + i['score'])
                    
                    if count == 0:
                        label.label_settings = LabelSettings.new()
                        
                        label.label_settings.font_size = 25
                        label.label_settings.font_color = Color(0,255,0)
                    elif count == 1:
                        label.label_settings = LabelSettings.new()
                        label.label_settings.font_size = 20
                        label.label_settings.font_color = Color(150,255,0)
                    elif count == 2:
                        label.label_settings = LabelSettings.new()
                        label.label_settings.font_size = 15
                        label.label_settings.font_color = Color(Color.CHOCOLATE)
                    else:
                        label.label_settings = LabelSettings.new()
                        label.label_settings.font_size = 12
                        label.label_settings.font_color = Color(255,255,255)
                        
                    label.text = (str(count+1) + "# " + i['name'] + ": " + get_time(int(i['score'])))

                    
                    people.add_child(label)
                    count += 1
            
            else:
                error.text = "there is only one person on the\nleaderboard which mean my\ncode breaks for some reason\nand i cant be bothered to fix it"
                    
            
        else:
            error.text = "there are no scores to show"
    
    else:
        people.get_child(0).text = "there is no one on the leader board!"

        
