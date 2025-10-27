extends CanvasLayer

const MOBILE_DEVICES = ["Android", "iOS", ""]

func _ready() -> void:
	var screen_size = DisplayServer.screen_get_size()
	var is_mobile = screen_size.x < 800 or screen_size.y < 600
	if is_mobile or DisplayServer.is_touchscreen_available():
		$Arrows.show()
	else:
		$Arrows.hide()
	
	$DebugLabel.text = str(OS.get_name()) + " : " + str(DisplayServer.screen_get_size()) + " : " + str(DisplayServer.is_touchscreen_available())

func _on_timer_timeout() -> void:
	var screen_size = DisplayServer.screen_get_size()
	var is_mobile = screen_size.x < 800 or screen_size.y < 600
	if is_mobile or DisplayServer.is_touchscreen_available():
		$Arrows.show()
	else:
		$Arrows.hide()
	
	$DebugLabel.text = str(DisplayServer.screen_get_size()) + " : " + str(DisplayServer.is_touchscreen_available())
