extends CharacterBody2D


const SPEED = 500.0
var is_dead = false

#
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#Die
func die():
	if is_dead:
		return
	is_dead = true
	# Dừng di chuyển
	velocity = Vector2.ZERO
	# Tắt xử lý input
	set_physics_process(false)
	# Chạy animation chết
	$AnimatedSprite2D.play("die")
	# Chờ thực thi hoạt ảnh 
	await $AnimatedSprite2D.animation_finished
func _ready():
	add_to_group("knight")
#Move
func _physics_process(delta: float) -> void:
	#get_vector sẽ chuẩn hóa việc đi xéo sẽ nhanh hơn đi thẳng. 
	#còn chuần hóa ntn thì bố đéo biết
	var direction = Input.get_vector(
	"move_left",
	"move_right",
	"move_up",
    "move_down"
)
	
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	if direction.x == 0 && direction.y == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	velocity = direction * SPEED
	move_and_slide()
