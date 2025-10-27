extends Area2D

var from: Vector2 = Vector2.ZERO
var to: Vector2 = Vector2.ZERO
var speed: float = 1.0

var velocity: Vector2

func _ready() -> void:
	global_position = from
	velocity = to - from


func _process(delta: float) -> void:
	position += velocity * delta * speed
	for p in get_overlapping_areas():
		if !p.is_in_group("immune"):
			p.die()
			die()
	
	if position.x < -50 or position.y < -50 or \
		position.x > Globals.camera_sizes[Globals.Games.bugs].x + 50 or \
		position.y > Globals.camera_sizes[Globals.Games.bugs].y + 50:
			die()

func die():
	queue_free()
