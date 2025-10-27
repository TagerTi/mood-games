extends Node2D

var car_scene = preload("res://Objects/falling_object.tscn")
var car_count: int = 6

var first_car_positions = []

const CAR_TEXTURES = [
	preload("res://Assets/Entities/Cars/CarBlue.png"),
	preload("res://Assets/Entities/Cars/CarCyan.png"),
	preload("res://Assets/Entities/Cars/CarGray.png"),
	preload("res://Assets/Entities/Cars/CarGreen.png"),
	preload("res://Assets/Entities/Cars/CarLilla.png"),
	preload("res://Assets/Entities/Cars/CarRed.png"),
]

func add_score(amount: int):
	$PlayerCar.add_score(amount)

func _ready() -> void:
	var available = [11,12,13,14,15,16,17,18,19, 20]
	for i in range(car_count):
		if len(available) > 0:
			var cur = available.pick_random()
			available.erase(cur)
			add_car(Vector2(cur*19, -40))

	Globals.camera_sizes[Globals.Games.traffic] = get_viewport_rect().size / $Camera.zoom
	Globals.current_game = Globals.Games.traffic
	randomize()

func _process(_delta: float) -> void:
	if $Cars.get_child_count() < car_count:
		add_car(Vector2(randi_range(11,20)*19, -40))

func add_car(pos: Vector2):
	var car = car_scene.instantiate()
	
	car.position = pos
	
	car.texture = CAR_TEXTURES.pick_random()
	car.velocity = Vector2(0,randi_range(100,150))
	
	var shape = RectangleShape2D.new()
	shape.size.x = 14
	shape.size.y = 30
	
	car.collision_shape = shape
	car.is_hostile = true
	
	car.particle_color = Color.from_rgba8(252, 144, 3, 255)
	
	car.connect("add_score", add_score)

	car.vflip = true
	
	$Cars.add_child(car)

func _on_timer_timeout() -> void:
	if car_count < 20:
		car_count += 1
		$Timer.wait_time += 1
