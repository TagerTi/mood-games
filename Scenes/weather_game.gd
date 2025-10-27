extends Node2D

var drop_scene = preload("res://Objects/falling_object.tscn")

var drop_count: int = 3

func add_score(amount: int = 5):
	$Player.score += amount

func add_drop(pos: Vector2, big:  bool = false):
	var drop = drop_scene.instantiate()
	
	drop.position = pos
	
	drop.texture = preload("res://Assets/Entities/WaterDropSmall.png") if !big else preload("res://Assets/Entities/WaterDropBig.png")
	drop.velocity = Vector2(randi_range(-10,10),randi_range(100,200))
	
	var shape = RectangleShape2D.new()
	shape.size.x = 7 if !big else 11
	shape.size.y = 12
	
	drop.collision_shape = shape
	drop.is_hostile = true
	
	drop.particle_color = Color.from_rgba8(0, 158, 249, 255)
	
	drop.connect("add_score", add_score)
	
	$Drops.add_child(drop)

func _ready() -> void:
	Globals.camera_sizes[Globals.Games.weather] = get_viewport_rect().size / $Camera.zoom
	randomize()

func _process(_delta: float) -> void:
	if $Drops.get_child_count() < drop_count:
		add_drop(Vector2(randi_range(5,Globals.camera_sizes[Globals.Games.weather].x - 5), -20))
		var new_drop_count = 5 + floor($Player.score / 75)
		if new_drop_count != drop_count:
			drop_count = new_drop_count
	
	#print("Review of current GameStats: ")
	#print("score: ", $Player.score)
	#print("drop_count: ", drop_count)
	#print("Current drops: ", $Drops.get_child_count())
	#print("cooldown: ", cooldown)
