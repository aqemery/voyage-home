extends Node

signal player_moved(x, y)
signal player_hit(group, x, y)
signal asteroid_hit(x, y)
signal enemy_hit(x, y)
signal refuel_hit(x, y)
signal wall_hit(x, y)
signal low_fuel
signal refuel


# Called when the node enters the scene tree for the first time.
func _ready():
    player_hit.connect(print_hit)
    low_fuel.connect(print_low_fuel)

    #pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
    #pass

func print_hit(group, x, y):
    prints("ship hit", group, "at", x, y)
    match group:
        "asteroid":
            print("asteroid hit")
        "enemy":
            print("enemy hit")
        "nebula":
            print("nebula hit")
        "refuel":
            print("refuel hit")
            refuel.emit()
        "player":
            print("player hit")
        "sensor":
            print("sensor hit")
        "ruin":
            print("ruin hit")
        "wall":
            print("wall hit")
        "wormhole":
            print("wormhole hit")

    pass

func print_low_fuel():
    print("low fuel!")
