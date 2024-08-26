extends AnimatedSprite2D


var relic = true
# Called when the node enters the scene tree for the first time.
func _ready():
    SignalManager.collect_relic.connect(collect)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func collect(x, y):
    if relic and position.distance_to(Vector2(x, y)) < 100:
        relic = false
        Inventory.relics += 1
        print("relic collected")
