extends CharacterBody2D

var bullet_scene = preload("res://PlayerData/bullet.tscn")

const SPEED := 150.

var cooldown := 0.4
var timer := 0.
var health := 3

var score := 0

func add_score(amount: int):
	score += amount

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	
	
	# var dirx = Input.get_axis("move_left","move_right")
	# var diry = Input.get_axis("move_up","move_down")

	var dirx = int(Input.is_action_pressed("move_right") or $UI/Arrows/Right.button_pressed) - \
		int(Input.is_action_pressed("move_left") or $UI/Arrows/Left.button_pressed)
	var diry = int(Input.is_action_pressed("move_down") or $UI/Arrows/Down.button_pressed) - \
		int(Input.is_action_pressed("move_up") or $UI/Arrows/Up.button_pressed)
	
	if diry:
		velocity.y = diry * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if dirx:
		velocity.x = dirx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()


	var direction = (get_global_mouse_position() - global_position).normalized()
	$GunAnchor.rotation = direction.angle()


	if get_global_mouse_position().x > global_position.x:
		$GunAnchor/Gun.flip_v = false
	else:
		$GunAnchor/Gun.flip_v = true

	if timer <= 0:
		if Input.is_action_pressed("p") and \
			!($UI/Arrows/Left.button_pressed or $UI/Arrows/Right.button_pressed or \
			$UI/Arrows/Down.button_pressed or $UI/Arrows/Up.button_pressed):
				shoot()
	else:
		timer -= delta
	
	for p in $EnemieHitbox.get_overlapping_areas():
		if p.has_method("die") and !p.is_dying:
			p.die()
			health -= 1
			if health == 0:
				die()
	$UI/HealthBar.value = health
	$UI/ScoreLabel.text = "Score: " + str(score)

func shoot():
	timer = cooldown
	var bullet = bullet_scene.instantiate()
	bullet.from = $GunAnchor/StartPos.global_position
	bullet.to = $GunAnchor/TargetPos.global_position
	bullet.speed = 400
	bullet.rotation = $GunAnchor.rotation
	get_parent().add_child(bullet)

func die():
	Globals.current_score = score
	print("TOOOOT")
	get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")
