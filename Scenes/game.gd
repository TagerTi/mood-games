extends Node2D

var mood: int = 0

var page_nodes = []
var page = 0

func _ready() -> void:
	page_nodes = get_children()
	page_nodes.remove_at(0)
	set_page(0)
	
	$ReasonChoice/MoodOptions/Bug/Control/Score.text = str(Globals.highscores[Globals.Games.bugs])
	$ReasonChoice/MoodOptions/Rain/Control/Score.text = str(Globals.highscores[Globals.Games.weather])
	$ReasonChoice/MoodOptions/NoDesire/Control/Score.text = str(Globals.highscores[Globals.Games.noDesire])
	$ReasonChoice/MoodOptions/Traffic/Control/Score.text = str(Globals.highscores[Globals.Games.traffic])

func set_page(number: int):
	for p in range(len(page_nodes)):
		if p == number:
			page_nodes[p].position.y = 0
			page_nodes[p].visible = true
			if number == 1:
				$Others/BackTimer.start(20)
				$ReasonChoice/Label.text = [
					"What worries you?", 
					"What's bothering you?", 
					"What could be better?",
					"What brightens your day?",
					"What makes you this happy?"][mood]
		else:
			page_nodes[p].position.y = 144
			page_nodes[p].visible = false
	page = number

func _process(_delta: float) -> void:
	$ReasonChoice/Back/ReturnIn.text = str(int($Others/BackTimer.time_left)) + "s"

func _on_timer_timeout() -> void:
	set_page(0)

# Mood Selection -------------------------------------
func _best_pressed() -> void:
	mood = 4
	set_page(1)

func _good_pressed() -> void:
	mood = 3
	set_page(1)

func _mid_pressed() -> void:
	mood = 2
	set_page(1)

func _bad_pressed() -> void:
	mood = 1
	set_page(1)

func _worse_pressed() -> void:
	mood = 0
	set_page(1)


# Game Selection -----------------------------

func _rain_pressed() -> void:
	Globals.current_game = Globals.Games.weather
	Globals.current_game_path = "res://Scenes/weather_game.tscn"
	get_tree().change_scene_to_file("res://Scenes/weather_game.tscn")


func _on_bug_button_pressed() -> void:
	Globals.current_game = Globals.Games.bugs
	Globals.current_game_path = "res://Scenes/bug_game.tscn"
	get_tree().change_scene_to_file("res://Scenes/bug_game.tscn")


func _on_back_pressed() -> void:
	set_page(0)


func _on_traffic_button_pressed() -> void:
	Globals.current_game = Globals.Games.traffic
	Globals.current_game_path = "res://Scenes/traffic_game.tscn"
	get_tree().change_scene_to_file("res://Scenes/traffic_game.tscn")
