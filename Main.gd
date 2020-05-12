extends Node2D

var Player = preload("res://Player.tscn")
var Box = preload("res://Box.tscn")

var player
var box

func _ready():
	randomize()
	new_game()

func new_game():
	player = Player.instance()
	player.position = Vector2(300,300)
	add_child(player)
	
	box = Box.instance()
	box.position = Vector2(700,300)
	add_child(box)
	player.connect("hooked", self, "_on_hooked")

func _on_hooked(object):
	var pos = object.get_global_position()
	var pos2 = player.get_global_position()
	$Tween.interpolate_property(object, "position",
				null, pos2, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
	object.get_parent().remove_child(object)
	player.add_child(object)

