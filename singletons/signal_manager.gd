extends Node

signal player_moved(x, y)
signal player_hit(group, x, y)
signal asteroid_hit(x, y)
signal enemy_hit(x, y)
signal refuel_hit(x, y)
signal wall_hit(x, y)
signal low_fuel
signal refuel

signal collect_astronomer
signal collect_engineer
signal collect_exobiologist
signal activate_tower(x, y)
signal collect_ore(x, y)


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
        "sensor":
            print("sensor hit")
            activate_tower.emit(x, y)
        "wall":
            print("wall hit")
        "wormhole":
            print("wormhole hit")
        "ore":
            print("ore hit")
            collect_ore.emit(x,y)

    pass

func print_low_fuel():
    print("low fuel!")
