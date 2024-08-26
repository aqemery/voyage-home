extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
    SignalManager.collect_ore.connect(collect)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
    
func collect(x, y):
    if position.distance_to(Vector2(x, y)) < 100:
        Inventory.ore += 1
        queue_free()
        
    
