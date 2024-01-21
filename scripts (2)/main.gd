extends Node2D
@onready var Player = $Player
@onready var lasers = $lasers
@onready var asteroids = $asteroids
@onready var hud = $UI/HUD

var asteroid_scene = preload("res://asteroid.tscn")
var score := 0:
	set(value):
		score = value
		hud.score = score
		
var lives = 3

func _ready():
	score = 0
	Player.connect("laser_shot", _on_player_laser_shot)
	$AsterTimer.start()
	##Player.connect("died", _on_player_died)
	var screen_size_one = get_viewport_rect().size
	Player.global_position.x = (screen_size_one.x/2)
	Player.global_position.y = (screen_size_one.y/2)
	for  asteroid in asteroids.get_children():
		asteroid.connect("exploded",_on_asteroid_exploded)
	
func  _on_player_laser_shot(laser):
	lasers.add_child(laser)

func _on_asteroid_exploded(pos,size,points):
	score+=points
	for i in range(2):
		match size:
			Asteroid.AsteroidSize.Big:
				spawn_asteroid(pos,Asteroid.AsteroidSize.Medium)
			Asteroid.AsteroidSize.Medium:
				spawn_asteroid(pos,Asteroid.AsteroidSize.Small)
			Asteroid.AsteroidSize.Small:
				pass
func spawn_asteroid(pos,size):
	var a = asteroid_scene.instantiate()
	a.global_position = pos
	a.size = size
	a.connect("exploded",_on_asteroid_exploded)
	asteroids.call_deferred("add_child",a)
	
##func _on_player_died():
	##lives -= 1
	##f lives <=0:
	##	get_tree().reload_current_scene()
	##else:
	##	var screen_size_one = get_viewport_rect().size
	##	var spawnPos = Vector2() 
	##	spawnPos.x =  (screen_size_one.x/2)
	##	spawnPos.y =  (screen_size_one.y/2)
	##	await get_tree().create_timer(1)
	##	Player.respawn(spawnPos)


func _on_aster_timer_timeout():
	if asteroids.get_child_count()<10 :
		var a = asteroid_scene.instantiate()
		a.connect("exploded",_on_asteroid_exploded)
		asteroids.call_deferred("add_child",a)
