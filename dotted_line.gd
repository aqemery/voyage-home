extends Node2D

@export var radius = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    rotation += delta * 0.1
    queue_redraw()
    pass

func _draw():
    var segments = radius
    var angle = 2
    #var radius = 50
    var step = 2 * PI / (segments * 3)

    for i in range(segments):
        var start = angle
        angle += step
        draw_arc(Vector2.ZERO, radius, start, angle, 10, Color.WHITE)
        angle += step * 2
