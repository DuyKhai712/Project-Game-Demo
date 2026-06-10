extends CharacterBody2D
@export var SPEED = 100
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var knight
func _ready():
	knight = get_tree().get_first_node_in_group("knight")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if knight == null:
		return
	var direction = (
		knight.global_position - global_position
	).normalized()
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	if direction.x == 0 && direction.y == 0:
		animated_sprite.play("spawn")
		await $AnimatedSprite2D.animation_finished
	else:
		animated_sprite.play("run")
	velocity  = direction * SPEED
	move_and_slide()
