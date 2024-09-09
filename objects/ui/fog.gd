extends Sprite2D

var BASE_DIST = 0.05
var MAX_DIST = 0.22

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    await get_tree().create_timer(.1).timeout
    SignalManager.player_moved.connect(update_region)
    print("connected")

func update_region(v: Vector2):
    material.set("shader_parameter/point", v / 50 / 337);
    texture = get_viewport().get_texture()
    
func expand(r: Callable):
    var tween = get_tree().create_tween().bind_node(self)
    tween.tween_method(set_shader_value, BASE_DIST, MAX_DIST, 2);
    tween.tween_callback(reset)
    tween.tween_callback(r)

func reset():
    set_shader_value(BASE_DIST)
    
func set_shader_value(value: float):
    material.set("shader_parameter/max_distance", value)
