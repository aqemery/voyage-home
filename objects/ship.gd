extends Area2D
class_name Ship

@onready var area_col = $area_col
@onready var physics_col = $RigidBody2D/physics_col
@onready var rigid_body_2d = $RigidBody2D
@onready var timer = $Timer

var max_speed = 100
var radius
var area
var raw_rotation = 0

var thrust = false

# Called when the node enters the scene tree for the first time.
func _ready():
    radius = area_col.shape.radius
    area = circle_area(radius)
    _draw()


func _on_timeout():
    ObjectMaker.make_breadcrumb(global_position)

func update_area(a: float):
    area = a
    radius = area_to_radius(a)
    area_col.shape.radius = radius
    physics_col.shape.radius = radius
    queue_redraw()

func update_radius(r: float):
    radius = r
    area = circle_area(radius)
    area_col.shape.radius = r
    physics_col.shape.radius = r
    queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func _physics_process(delta):
    var r_input = Input.get_axis("ui_left", "ui_right")
    #raw_rotation += r_input * delta * 200
    
    #rotation_degrees =  int(int(raw_rotation) / 10) * 10
    rotate(r_input * delta * 5)
    global_position = $RigidBody2D.global_position
    $RigidBody2D.position = Vector2.ZERO
    
    
    if FuelManager.fuel > 4:
        queue_free()
        
        
    # key down
    thrust = false
    queue_redraw()
    if Input.is_action_pressed("fire"):
        fire()
    
        
    SignalManager.player_moved.emit(global_position)


func fire():
    #print("fuel: ", FuelManager.fuel)

    # don't accelerate if max speed is reached
    if FuelManager.fuel >= 0:
        thrust = true
        FuelManager.fuel -= .002
        rigid_body_2d.apply_central_impulse(Vector2(0, -5).rotated(rotation))

    #if rigid_body_2d.linear_velocity.length() > max_speed:
        #thrust = false
        #FuelManager.fuel += .002
        #rigid_body_2d.linear_velocity = rigid_body_2d.linear_velocity.normalized() * (max_speed - 1)
    #
    #if rigid_body_2d.linear_velocity.length() >= max_speed - 2:
        #thrust = false
        

func suck(other):
    var diff = other.global_position.distance_to(area_col.global_position)
    var other_radius = diff - radius
    var suck_radius = other.area - circle_area(other_radius)
    

    FuelManager.fuel += suck_radius / area
    if other_radius <= 0:
        other.queue_free()
    else:
        if other_radius < other.radius:
            other.update_radius(other_radius)

func circle_area(r: float):
    return PI * r * r

func area_to_radius(a: float):
    return sqrt(a / PI)
#
func _draw():
    #draw_circle(center, circle.radius, Color.BLACK)
    #draw_circle(position, circle.radius, Color.BLACK)
    draw_arc(Vector2.ZERO, area_col.shape.radius, 0, 2 * PI, 45, Color.BLACK, 1)
    # draw a trangle
    draw_colored_polygon([
        Vector2(0, -area_col.shape.radius + 1),
        Vector2(-area_col.shape.radius + 3, area_col.shape.radius - 4),
        Vector2(0, area_col.shape.radius - 6),
        Vector2(area_col.shape.radius - 3, area_col.shape.radius - 4),
       
    ], Color.BLACK)

    if thrust:
        draw_colored_polygon([
            Vector2(0, 5),
            Vector2(3, 7),
            Vector2(0, 20),
            Vector2(-3, 7),
        ], Color.BLACK)


func _on_rigid_body_2d_body_entered(body):
    for g in body.get_groups():
        if "_root" in g:
            continue
        SignalManager.player_hit.emit(g, global_position.x, global_position.y)
        #prints("hit something", g)
    


func _on_timer_timeout():
     ObjectMaker.make_breadcrumb(global_position)
