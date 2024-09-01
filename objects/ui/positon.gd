extends Node2D

var state = false

func _ready() -> void:
    SignalManager.player_moved.connect(update_region)
    pass
    
func _draw():
    match state:
        true:
            draw_line(Vector2(0, 0), Vector2(0, 1), Color.BLACK, 1)
        false:
            draw_line(Vector2(0, 0), Vector2(0, 1), Color.WHITE, 1)
    state = !state

func _on_timer_timeout():
    queue_redraw()
    
func update_region(v: Vector2):
    position = v / 50
