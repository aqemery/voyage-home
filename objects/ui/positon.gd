extends Node2D

var state = false
    
func _draw():
    match state:
        true:
            draw_line(Vector2(0, 0), Vector2(0, 1), Color.BLACK, 1)
        false:
            draw_line(Vector2(0, 0), Vector2(0, 1), Color.WHITE, 1)
    state = !state

func _on_timer_timeout():
    queue_redraw()
