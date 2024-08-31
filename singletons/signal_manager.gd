extends Node

signal player_moved(x, y)
signal player_hit(group, x, y)
signal asteroid_hit(x, y)
signal enemy_hit(x, y)
signal refuel_hit(x, y)
signal wall_hit(x, y)
signal low_fuel
signal refuel
signal warp(pos)

signal collect_astronomer
signal collect_engineer
signal collect_exobiologist


func _ready():
    player_hit.connect(print_hit)
    low_fuel.connect(print_low_fuel)

func print_hit(group, x, y):
    prints("ship hit", group, "at", x, y)
    match group:
        "asteroid":
            print("asteroid hit")
        "enemy":
            print("enemy hit")
        "nebula":
            print("nebula hit")
        "wall":
            print("wall hit")

func print_low_fuel():
    print("low fuel!")
