extends Node2D

@export var monster_scene : PackedScene
@export var spawn_radius := 300.0
@export var max_monsters := 20

var monster_count := 0

func _ready():
	$Timer.wait_time = 0.0000005
	$Timer.start()
	

func _on_timer_timeout():
	var knight = get_tree().get_first_node_in_group("knight")
	if knight == null:
		return
	var angle = randf() * TAU
	var spawn_position = (
		knight.global_position +
		Vector2(
			cos(angle),
			sin(angle)
		) * spawn_radius
	)
	if monster_count >= max_monsters:
		return
	monster_count += 1
	var monster = monster_scene.instantiate()
	monster.global_position = spawn_position
	get_parent().add_child(monster)
