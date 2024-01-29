extends Node

var debug_mode = false
var version = "alpha.1.1.1"
# rules for version
# - first word is release status, first num is major release/update, second is hotfix and 3rd just goes up when i make a commit

var current_level = 1
var score := "0.0"
var int_score := 0
var global_start_time := 0
var local_name := "Testificate"
var local_color := Color(255,255,255,255)

var selected_tile: int = 0
