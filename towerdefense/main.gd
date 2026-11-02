extends Node2D


var instance

func spawn():
	var Grid = load("res://Grid.tscn")
	instance = Grid.instantiate()
	add_child(instance)

func despawn():
	instance.queue_free()

func _ready():
	pass


var loaded = false

func _on_button_pressed() -> void:
	if loaded == false:
		spawn()
		loaded = true
	elif loaded == true:
		despawn()
		loaded = false
