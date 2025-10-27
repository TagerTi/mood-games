extends Node

enum Games{
	weather,
	bugs,
	traffic,
	noDesire,
}

var camera_sizes: = {
	Games.weather: Vector2(384,216),
	Games.bugs: Vector2(576,324),
	Games.traffic: Vector2(576,324),
}

var is_highscore: = false
var current_game: Games = Games.weather
var current_game_path: = "res://Scenes/weather_game.tscn"
var current_score: = 0:
	set(value):
		current_score = value
		load_highscores()
		if value > highscores[current_game]:
			highscores[current_game] = value
			is_highscore = true
			save_highscores()
		else:
			is_highscore = false

var highscores: = {
	Games.weather: 0,
	Games.bugs: 0,
	Games.noDesire: 0,
	Games.traffic: 0,
}

func _ready() -> void:
	load_highscores()

func save_highscores() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("scores", "highscores", highscores)
	var err := cfg.save("user://highscores.cfg")
	if err != OK:
		push_error("Could not save highscores: %s" % err)

func load_highscores() -> void:
	var cfg := ConfigFile.new()
	var err := cfg.load("user://highscores.cfg")
	if err == OK:
		var data = cfg.get_value("scores", "highscores", null)
		if typeof(data) == TYPE_DICTIONARY:
			highscores = data
