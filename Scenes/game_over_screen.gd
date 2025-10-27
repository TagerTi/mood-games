extends Node2D

func _ready() -> void:
	$CanvasLayer/Score.text = ""
	if Globals.is_highscore:
		$CanvasLayer/Score.text += "!!! NEW HIGHSCORE !!! \n"
	$CanvasLayer/Score.text += "Score: " + str(Globals.current_score)

func _process(_delta: float) -> void:
	$CanvasLayer/QuitTimerLabel.text = "Go to menu in: " + str(int($QuitTimer.time_left)) + "s"

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file(Globals.current_game_path)


func _on_quit_timer_timeout() -> void:
	_on_home_pressed()
