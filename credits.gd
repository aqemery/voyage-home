extends Node2D

@onready var label: Label = $Label
var can_transition = false


func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

# on event "fire" emit transistion to root scene
func _input(event):
    if event.is_action_released("fire") and can_transition:
        get_tree().change_scene_to_file("res://title.tscn")


func _on_animated_sprite_2d_animation_finished() -> void:
    label.visible = true
    can_transition = true
    
        
    
    
