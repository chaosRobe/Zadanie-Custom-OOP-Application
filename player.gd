class_name Player extends CharacterBody2D

signal laser_shot(laser)

@export var acceleration := 10.0
@export var max_speed := 350.0
@export var rotation_speed := 250.0

@onready var Gun = $Gun

var laser_scene = preload("res://laser.tscn")

var shoot_cd = false
var rate_of_fire = 0.15

var alive := true

func _process(delta):

	
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot_laser()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false

func _physics_process(delta):

	var input_vector := Vector2(0, Input.get_axis("up", "down"))
	
	velocity += input_vector.rotated(rotation) * acceleration
	velocity = velocity.limit_length(max_speed)
	
	if Input.is_action_pressed("right"):
		rotate(deg_to_rad(rotation_speed*delta))
	if Input.is_action_pressed("left"):
		rotate(deg_to_rad(-rotation_speed*delta))
	
	if input_vector.y == 0:
		velocity = velocity.move_toward(Vector2.ZERO, 3)
	
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	if global_position.y < 0:
		global_position.y = screen_size.y
	elif global_position.y > screen_size.y:
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0

func shoot_laser():
	var missile = laser_scene.instantiate()
	missile.global_position = Gun.global_position
	missile.rotation = rotation
	emit_signal("laser_shot", missile)
