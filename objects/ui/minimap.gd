extends Node2D

@onready var sectors = $"SubViewportContainer/SubViewport/minimap-level"
var x = 0
var y = 0

var origin_f = Vector2(0, -3)

func _ready():
    SignalManager.player_moved.connect(update_region)    
    
func update_region(v: Vector2):
    sectors.position = origin_f - (v / 50)  - Vector2(26 - 51, 24 - 52)
