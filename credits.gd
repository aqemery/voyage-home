extends Node2D

#const ROOT = preload("res://root.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

# on event "fire" emit transistion to root scene
func _input(event):
    if event.is_action_pressed("fire"):
        get_tree().change_scene_to_file("res://title.tscn")