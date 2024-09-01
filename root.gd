extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $CanvasLayer3.offset.x = -1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
    
func _input(event: InputEvent) -> void:
    # check for "show_minimap"
    if event.is_action_pressed("show_minimap"):
        $CanvasLayer3.offset.x = 60
    elif event.is_action_released("show_minimap"):
        $CanvasLayer3.offset.x = -1000
