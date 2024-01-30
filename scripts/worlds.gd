extends ScrollContainer

@onready var grid = $GridContainer
var levels = "res://scenes/levels/"
var og_level = "res://scenes/levels/og map/"
var random_game = "res://scenes/levels/game1/"

func _ready():
    for file in DirAccess.get_files_at(levels):
        var button = Button.new()
        button.text = file.split(".")[0]
        button.pressed.connect(open_scene.bind(levels + file))
        grid.add_child(button)
    grid.add_child(HSeparator.new())
    for file in DirAccess.get_files_at(og_level):
        if file != "main.tscn":
            var button = Button.new()
            button.text = file.split(".")[0]
            button.pressed.connect(open_scene.bind(og_level + file))
            grid.add_child(button)
    for file in DirAccess.get_files_at(random_game):
        if file == "main.tscn":
            var button = Button.new()
            button.text = file.split(".")[0]
            button.pressed.connect(open_scene.bind(random_game + file))
            grid.add_child(button)
            print("SDFSDF")


func open_scene(scene: String):
    get_tree().change_scene_to_file(scene)
