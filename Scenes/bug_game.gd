extends Node2D

var bug_scene = preload("res://Objects/following_object.tscn")

func _ready() -> void:
	Globals.camera_sizes[Globals.Games.bugs] = get_viewport_rect().size / $Camera.zoom
	randomize()

var cooldown : float = 1.
var timer : float = 0.

var speed : float = 30.

var get_harder_timer : float = 1.

func _process(delta: float) -> void:
	timer -= delta
	get_harder_timer -= delta
	if timer <= 0:
		timer = cooldown
		var rn : float = randf()
		if rn < .25:
			add_bug(Vector2(randi_range(0,Globals.camera_sizes[Globals.Games.bugs].x), -30))
		elif rn < .50:
			add_bug(Vector2(randi_range(0,Globals.camera_sizes[Globals.Games.bugs].x), Globals.camera_sizes[Globals.Games.bugs].y + 30))
		elif rn < .75:
			add_bug(Vector2(-30, randi_range(0,Globals.camera_sizes[Globals.Games.bugs].y)))
		else:
			add_bug(Vector2(Globals.camera_sizes[Globals.Games.bugs].x + 30, randi_range(0,Globals.camera_sizes[Globals.Games.bugs].y)))	

	if get_harder_timer <= 0:
		get_harder_timer = 1.
		cooldown = lerp(cooldown, 0.1, 0.007778)
		$LevPlayer.cooldown = cooldown * 0.8
		#print("(2 * speed) / (3 - cooldown) = ", 1/cooldown*speed)
		#print("Cooldown ist nun: ", cooldown)

func add_score(amount: int):
	$LevPlayer.add_score(amount)

func add_bug(pos: Vector2):
	var bug : Node = bug_scene.instantiate()
	
	bug.position = pos
	
	bug.texture = preload("res://Assets/Entities/Bug.png")
	bug.target = $LevPlayer
	
	var shape : RectangleShape2D = RectangleShape2D.new()
	shape.size.x = 30
	shape.size.y = 24
	
	bug.collision_shape = shape
	bug.is_hostile = true
	bug.speed = 1/cooldown*speed
	
	bug.particle_color = Color.from_rgba8(100, 0, 0, 255)
	
	bug.connect("add_score", $LevPlayer.add_score)
	
	$Bugs.add_child(bug)
