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
signal checkpoint
signal reset_fog
signal respawn
signal enemy_moved(id, pos)
signal comms_upgraded()

signal collect_astronomer
signal collect_engineer
signal collect_exobiologist

signal activate_tower(id)
signal collect_ore(id)

signal enter_enemy
signal leave_enemy


func _ready():
    player_hit.connect(print_hit)

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
