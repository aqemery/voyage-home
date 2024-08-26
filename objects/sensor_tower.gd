extends AnimatedSprite2D


var active = false
# Called when the node enters the scene tree for the first time.
func _ready():
    SignalManager.activate_tower.connect(collect)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func collect(x, y):
    if not active and position.distance_to(Vector2(x, y)) < 100:
        Inventory.towers += 1
        # start animation "powerup" when finished play "powered"
        play("powerup")
        active = true
        


func _on_animation_finished():
    play("powered")
