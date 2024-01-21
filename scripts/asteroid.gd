class_name Asteroid extends Area2D

signal exploded(pos,size,points)

var movement_vector := Vector2(0,-2)
var speed = 50
enum AsteroidSize{Big,Medium,Small}
@export var size :=AsteroidSize.Big
var points: int:
	get:
		match size:
			AsteroidSize.Big:
				return 50
			AsteroidSize.Medium:
				return 100
			AsteroidSize.Small:
				return 150
			_:
				return 0
func _ready():
	rotation = randf_range(0,2*PI)
	match size:
		AsteroidSize.Big:
			speed = randf_range(50,100)
			global_scale = Vector2(1,1)
		AsteroidSize.Medium:
			speed = randf_range(100,150)
			global_scale = Vector2(0.5,0.5)
		AsteroidSize.Small:
			speed = randf_range(100,200)
			global_scale = Vector2(0.2,0.2)


func _physics_process(delta):
	var screen_size = get_viewport_rect().size
	
	global_position += movement_vector.rotated(rotation) * speed * delta
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0
		
func explode():
	emit_signal("exploded",global_position,size,points)
	queue_free()


func _on_body_entered(body):
	if body is Player:
		var player = body
		##player.death()
