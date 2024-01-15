extends Node2D
@onready var Player = $Player
@onready var lasers = $lasers


func _ready():
	Player.connect("laser_shot", _on_player_laser_shot)
	
func  _on_player_laser_shot(laser):
	lasers.add_child(laser)
