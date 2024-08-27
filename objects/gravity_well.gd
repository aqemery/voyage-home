extends Area2D
var radius

@onready var collision_shape_2d = $CollisionShape2D

var marker: Marker2D

func _ready():
    marker = find_child("Marker2D")
    radius = collision_shape_2d.shape.radius

func _physics_process(delta):
    radius -= delta * 50
    if radius < 0:
        radius = collision_shape_2d.shape.radius
    queue_redraw()
    
func value(r):
    if r < 0:
        return collision_shape_2d.shape.radius - r
    if r > collision_shape_2d.shape.radius:
        return r - collision_shape_2d.shape.radius
    return r

func _draw():
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

func _on_area_2d_body_entered(body):
    SignalManager.warp.emit(marker.global_position)
