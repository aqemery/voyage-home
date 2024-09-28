extends Sprite2D

var BASE_DIST = 0.05
var MAX_DIST = 0.22
var POS

const SECTORS_HIDDEN = preload("res://images/sectors-hidden.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    await get_tree().create_timer(.1).timeout
    SignalManager.player_moved.connect(update_region)
    SignalManager.checkpoint.connect(save_fog)
    SignalManager.reset_fog.connect(reset_fog)

func update_region(v: Vector2):
    POS = v
    material.set("shader_parameter/point", v / 50 / 337);
    var texture_image = get_viewport().get_texture().get_image()
    texture = ImageTexture.create_from_image(texture_image)
    
    
func expand(r: Callable):
    var tween = get_tree().create_tween().bind_node(self)
    tween.tween_method(set_shader_value, BASE_DIST, MAX_DIST, 2);
    tween.tween_callback(reset)
    tween.tween_callback(r)

func reset():
    update_region(POS)
    set_shader_value(BASE_DIST)
    
func set_shader_value(value: float):
    material.set("shader_parameter/max_distance", value)

func save_fog():
    Inventory.fog_image = get_viewport().get_texture().get_image()
    
func reset_fog():
    await get_tree().create_timer(.1).timeout
    if !Inventory.fog_image:
        Inventory.fog_image = SECTORS_HIDDEN.get_image()
        
    texture = ImageTexture.create_from_image(Inventory.fog_image)


    
