extends Node2D
@onready var sprite: AnimatedSprite2D = $sprite
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

#const ROOT = preload("res://root.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
    await get_tree().create_timer(0.5).timeout
    sprite.play()
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

# on event "fire" emit transistion to root scene
func _input(event):
    if event.is_action_released("fire"):
        get_tree().change_scene_to_file("res://intro.tscn")

    if event.is_action_released("esc"):
        get_tree().quit()
