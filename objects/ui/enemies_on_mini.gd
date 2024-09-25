extends Node2D

var enemy_map = {}
const ENEMY_MINI_MAP = preload("res://enemy_mini_map.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    SignalManager.enemy_moved.connect(enemy_moved)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func enemy_moved(id, pos):
    if id not in enemy_map:
        var enemy = ENEMY_MINI_MAP.instantiate()
        add_child(enemy)
        enemy_map[id] = enemy
    enemy_map[id].global_position = pos / 50


    
