@tool
extends Area2D

@export
var target: Node2D

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

var speed: float = 30.
var is_dying = false
signal add_score(amount)

func die():
	if !is_dying:
		add_to_group("immune")
		$Sprite.hide()
		$DeadParticle.emitting = true
		add_score.emit(5)
		is_dying = true

func _on_dead_particle_finished() -> void:
	queue_free()

func _ready() -> void:
	$DeadParticle.connect("finished", _on_dead_particle_finished)
	Globals.current_game = Globals.Games.bugs
	Globals.current_game_path = "res://Scenes/bug_game.tscn"
	$Sprite.texture = texture
	$Hitbox.shape = collision_shape
	$DeadParticle.color = particle_color
	
	set_collision_layer_value(2,is_hostile)
	set_collision_layer_value(3,!is_hostile)
	
	set_collision_mask_value(2,is_hostile)
	set_collision_mask_value(3,!is_hostile)

func _process(delta: float) -> void:
	if target:
		look_at(target.position)
		rotation_degrees -= 90
	if !Engine.is_editor_hint():
		position += ($Marker2D.global_position - global_position) * delta * speed
	
	for p in get_overlapping_areas():
		if p.is_in_group("dieable") and !p.is_dying:
			die()
