extends Camera2D

func _input(event: InputEvent) -> void:
    if get_tree().paused:
        return 
    if event.is_action_pressed("show_minimap"):
        anchor_mode = ANCHOR_MODE_DRAG_CENTER
    elif event.is_action_released("show_minimap"):
        anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT
