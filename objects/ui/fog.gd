extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    await get_tree().create_timer(.1).timeout
    #texture = get_viewport().get_texture()
    #print("texture set")
    SignalManager.player_moved.connect(update_region)
    print("connected")
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
    #material.set("shader_paramater/point",Vector2(100,100));
    #pass
    
    
func update_region(v: Vector2):
    material.set("shader_parameter/point", v / 50 / 337);
    texture = get_viewport().get_texture()
