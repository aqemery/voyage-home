extends Node2D

var state = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func _draw():
    match state:
        true:
            draw_line(Vector2(0,0),Vector2(0,1), Color.BLACK, 1)
        false:
            draw_line(Vector2(0,0),Vector2(0,1), Color.WHITE, 1)
    state = !state
    
    

func _on_timer_timeout():
    queue_redraw()
