extends Area2D
var radius

@onready var collision_shape_2d = $CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
    radius = collision_shape_2d.shape.radius


func _physics_process(delta):
    radius -= delta * 50
    if radius < 0:
        radius = collision_shape_2d.shape.radius
        # redraw the circle
    queue_redraw()
    
func value(r):
    if r < 0:
        return collision_shape_2d.shape.radius - r
    if r > collision_shape_2d.shape.radius:
        return r - collision_shape_2d.shape.radius
    return r

func _draw():

    #draw_circle(Vector2.ZERO, 90, Color(1, 1, 1, 0.5))
    #draw_circle(Vector2.ZERO, 90, Color(1, 1, 1, 0.5))
    #draw_circle(Vector2.ZERO, 90, Color(1, 1, 1, 0.5))
    #draw_circle(Vector2.ZERO, 10, Color.BLACK)

    # make a circle of 10 arc segments
    var segments = 20
    var angle = 2
    var cr = collision_shape_2d.shape.radius
    
    var step = 2 * PI / (segments * 2)
    for i in range(segments):
        var start = angle
        angle += step
        draw_arc(Vector2.ZERO, radius, start, angle, 10, Color.BLACK)
        draw_arc(Vector2.ZERO, value(radius + (cr/3)), start, angle, 10, Color.BLACK)
        draw_arc(Vector2.ZERO, value(radius + (2*cr/3)), start, angle, 10, Color.BLACK)
        angle += step


    

