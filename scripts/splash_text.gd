extends Label

var splash_messages: Array
@onready var splash_label = $"."
@onready var name_box = $"../../TabContainer/customization/name/name_input"
var before: String

func _ready():
    splash_messages = ["Now with semantic naming!", "now with fortnite", "now with splash textSS", "this animation is shit", "now with free robux", "comes in all colours", "jump and jump!", "try not to cry in a seat!", "be careful friends.", "now with shitty scoreboard", "speedrunsed as the world record", "big poo", "e0", "make sure to star!", "notch was here", "GO PLAY MINECRAFT", "i like chezburgers, too!", "num num num", "try not to laugh with a crumb in your mouth"]
    splash_label.text = splash_messages.pick_random()
    
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

    before = splash_label.text

    if name_box.text == "speedrunsed":
        splash_label.text = "sed."
        splash_label.size.x = 1000
    else:
        splash_label.text = before
    splash_label.pivot_offset.x = splash_label.size.x / 2
        
