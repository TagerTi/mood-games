extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0
var health = 3
var score = 0

func _ready() -> void:
	$UI.visible = true

func _physics_process(delta: float) -> void:
	$UI/HealthBar.value = health
	$UI/ScoreLabel.text = "Score: " + str(score)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var dirx = int(Input.is_action_pressed("move_right") or $UI/Arrows/Right.button_pressed) - \
		int(Input.is_action_pressed("move_left") or $UI/Arrows/Left.button_pressed)
	var diry = int(Input.is_action_pressed("move_down") or $UI/Arrows/Down.button_pressed) - \
		int(Input.is_action_pressed("move_up") or $UI/Arrows/Up.button_pressed)
	
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
