extends Area2D
class_name Ship

@onready var area_col = $area_col
@onready var physics_col = $RigidBody2D/physics_col
@onready var rigid_body_2d = $RigidBody2D
@onready var timer = $Timer

var ship_body = preload("res://objects/ship/ship_body.tscn")
var max_speed = 100
var radius
var area
var raw_rotation = 0

var thrust = false
var warp_vector = null

# Called when the node enters the scene tree for the first time.
func _ready():
    SignalManager.warp.connect(warp)
    radius = area_col.shape.radius
    _draw()


func _on_timeout():
    ObjectMaker.make_breadcrumb(global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func _physics_process(delta):
    if not rigid_body_2d:
        return
    var r_input = Input.get_axis("ui_left", "ui_right")
    #raw_rotation += r_input * delta * 200
    
    
    #rotation_degrees =  int(int(raw_rotation) / 10) * 10
    rotate(r_input * delta * 5)
    global_position = rigid_body_2d.global_position
    rigid_body_2d.position = Vector2.ZERO
    
    
    if FuelManager.fuel > 4:
        queue_free()
        
        
    # key down
    thrust = false
    queue_redraw()
    if Input.is_action_pressed("fire"):
        fire()
    
        
    SignalManager.player_moved.emit(global_position)


func fire():
    if FuelManager.fuel >= 0:
        thrust = true
        FuelManager.fuel -= .002
        rigid_body_2d.apply_central_impulse(Vector2(0, -5).rotated(rotation))
    

func _draw():
    draw_arc(Vector2.ZERO, area_col.shape.radius, 0, 2 * PI, 45, Color.BLACK, 1)
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

func _on_timer_timeout():
     ObjectMaker.make_breadcrumb(global_position)

func warp(pos: Vector2):
    var lv = rigid_body_2d.linear_velocity
    rigid_body_2d.queue_free()
    var effect = load("res://effects/warp-effect.tscn").instantiate()
    get_tree().root.add_child(effect)

    await get_tree().create_timer(1.5).timeout
    effect.queue_free()
    
    rigid_body_2d = ship_body.instantiate()
    global_position = pos
    rigid_body_2d.linear_velocity = lv
    add_child(rigid_body_2d)