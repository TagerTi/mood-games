extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
var health = 3
var score = 0

var screen_buttons = {
	"up": false,
	"down": false,
	"right": false,
	"left": false,
}

func _ready() -> void:
	$UI.visible = true

func _physics_process(delta: float) -> void:
	$UI/HealthBar.value = health
	$UI/ScoreLabel.text = "Score: " + str(score)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var diry : int = int(Input.is_action_pressed("move_down") or screen_buttons["down"]) - \
		int(Input.is_action_pressed("move_up") or screen_buttons["up"])
		
	var dirx : int = int(Input.is_action_pressed("move_right") or screen_buttons["right"]) - \
		int(Input.is_action_pressed("move_left") or screen_buttons["left"])
	
	if diry == -1 and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if dirx:
		velocity.x = dirx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	for p in $EnemieHitbox.get_overlapping_areas():
		if !p.is_dying:
			p.die()
			health -= 1
			if health == 0:
				Globals.current_score = score
				get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")


func _on_right_button_down() -> void:
	screen_buttons["right"] = true
func _on_right_button_up() -> void:
	screen_buttons["right"] = false

func _on_up_button_down() -> void:
	screen_buttons["up"] = true
func _on_up_button_up() -> void:
	screen_buttons["up"] = false

func _on_down_button_down() -> void:
	screen_buttons["down"] = true
func _on_down_button_up() -> void:
	screen_buttons["down"] = false

func _on_left_button_down() -> void:
	screen_buttons["left"] = true
func _on_left_button_up() -> void:
	screen_buttons["left"] = false
