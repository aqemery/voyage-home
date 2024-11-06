extends Node2D
@onready var sprite: AnimatedSprite2D = $sprite
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var pause_menu: CanvasLayer = $pause_menu

func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
    await get_tree().create_timer(0.5).timeout
    sprite.play()


func _input(event):
    if event.is_action_released("fire"):
        get_tree().change_scene_to_file("res://scenes/intro.tscn")
