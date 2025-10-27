@tool
extends Area2D

@export
var velocity: Vector2

@export
var texture: CompressedTexture2D:
	set(value):
		texture = value
		if get_node_or_null("Sprite"):
			$Sprite.texture = value

@export
var collision_shape: Shape2D:
	set(value):
		collision_shape = value
		if get_node_or_null("Hitbox"):
			$Hitbox.shape = value

@export
var particle_color: Color:
	set(value):
		particle_color = value
		if get_node_or_null("DeadParticle"):
			$DeadParticle.color = value

@export
var is_hostile: bool:
	set(value):
		is_hostile = value
		set_collision_layer_value(2,value)
		set_collision_layer_value(3,!value)
		
		set_collision_mask_value(2,value)
		set_collision_mask_value(3,!value)

@export
var vflip : bool:
	set ( value ):
		vflip = value
		$Sprite.flip_v = value

var is_dying = false
signal add_score(amount)

func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		position += velocity * delta
		if position.x < -100 or position.y < -100 or \
			position.x > Globals.camera_sizes[Globals.current_game].x + 100 or \
			position.y > Globals.camera_sizes[Globals.current_game].y + 100:
				add_score.emit(5)
				queue_free()
	
	for p in get_overlapping_areas():
		if p.is_in_group("dieable") and !p.is_dying:
			die()

func _ready() -> void:
	$Sprite.texture = texture
	$Hitbox.shape = collision_shape
	$DeadParticle.color = particle_color
	
	set_collision_layer_value(2,is_hostile)
	set_collision_layer_value(3,!is_hostile)
	
	set_collision_mask_value(2,is_hostile)
	set_collision_mask_value(3,!is_hostile)

func die():
	if !is_dying:
		$Sprite.hide()
		$DeadParticle.emitting = true
		is_dying = true

func _on_cpu_particles_2d_finished() -> void:
	queue_free()
