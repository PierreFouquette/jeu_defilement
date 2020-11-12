extends Node2D


export(int) var vitesse = 100
onready var pathfollow = $Path2D/PathFollow2D




func _process(delta):
	var offset_actuel = pathfollow.get_offset()
	pathfollow.set_offset(offset_actuel + vitesse * delta)
