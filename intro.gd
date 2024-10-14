extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    get_tree().change_scene_to_file("res://root.tscn")
    
func _input(event):
    if event.is_action_released("fire"):
        var next_step = int(animation_player.current_animation_position) / 5 * 5 + 5.0
        if next_step > 27:
            next_step = 26.9
        print(next_step)
        animation_player.seek(next_step)
