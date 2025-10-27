extends CharacterBody2D

const SPEED := 15.
const BASE_VELOCITY := Vector2(0,-400)

var score := 0
var health := 3

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	var dirx = int(Input.is_action_pressed("move_right") or $UI/Arrows/Right.button_pressed) - \
		int(Input.is_action_pressed("move_left") or $UI/Arrows/Left.button_pressed)
	var diry = int(Input.is_action_pressed("move_down") or $UI/Arrows/Down.button_pressed) - \
		int(Input.is_action_pressed("move_up") or $UI/Arrows/Up.button_pressed)
	
	velocity.x += dirx * SPEED
	velocity.y += diry * SPEED

	velocity.x *= 0.95
	velocity.y *= 0.95

	var direction = (velocity + BASE_VELOCITY).normalized()
	var angle = direction.angle()

	$Sprite.rotation = angle + PI/2
	$Hitbox.rotation = angle + PI/2

	move_and_slide()

	$UI/HealthBar.value = health
	$UI/ScoreLabel.text = "Score: " + str(score)

	for p in $EnemieHitbox.get_overlapping_areas():
		if !p.is_dying:
			p.die()
			health -= 1
			if health == 0:
				Globals.current_score = score
				print("TOOOOT")
				get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
	
	$UI/HealthBar.value = health

func add_score(amount: int = 5):
	score += amount
