extends RigidBody2D


const SPEED = 25.0
const max_speed = 250
var player_pos = Vector2(0, 0)
var rotation_speed = 2
var thrust = false
var starting_pos = Vector2(0, 0)
var chase_range = 1500

@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _ready():
    SignalManager.player_moved.connect(getPlayerPos)
    starting_pos = global_position

func _physics_process(delta: float) -> void:
    var move_to = player_pos
    
    # if distance from player is greater than chase range, move to starting position
    if global_position.distance_to(player_pos) > chase_range:
        move_to = starting_pos

    # if distance from starting position is greater than chase range, move to player position
    if global_position.distance_to(starting_pos) > chase_range:
        move_to = starting_pos
    
    # get angle to player position
    var angle = get_angle_to(move_to) + PI/2

    if angle > 0:
        rotation += rotation_speed * delta
    else:
        rotation -= rotation_speed * delta
    
    if linear_velocity.length() > max_speed:
        linear_velocity = linear_velocity.normalized() * max_speed
        
    if abs(angle) < 0.1:
        thrust = true
        apply_central_impulse(Vector2(0, -SPEED).rotated(rotation))
    queue_redraw()
    SignalManager.enemy_moved.emit(name, global_position)

    # if move to is starting_pos and disance is less than 10, stop moving
    if move_to == starting_pos and global_position.distance_to(starting_pos) < 10:
        thrust = false
        linear_velocity = Vector2(0, 0)

    # if player ship is hit by ray_cast_2d, respawn
    if ray_cast_2d.is_colliding():
        SignalManager.respawn.emit()
    
func getPlayerPos(pos):
    player_pos = pos
    
func _draw() -> void:    
    draw_colored_polygon([
        Vector2(3, 3),
        Vector2(5, 10),
        Vector2(5, 3),
        Vector2(10, 5),
        Vector2(2, -6),
        Vector2(-2, -6),
        Vector2(-10, 5),
        Vector2(-5, 3),
        Vector2(-5, 10),
        Vector2(-3, 3),
    ], Color.WHITE)
    
    if thrust:
        draw_colored_polygon([
            Vector2(0, 5),
            Vector2(3, 7),
            Vector2(0, 20),
            Vector2(-3, 7),
        ], Color.WHITE)
            
