extends Node2D


const Grid := preload("res://Grid.tscn")

func spawn():
	var instance = Grid.instantiate()
	add_child(instance)

func _ready():
	spawn()
