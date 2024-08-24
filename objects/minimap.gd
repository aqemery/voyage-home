extends Node2D

@onready var sectors = $Sectors

# Called when the node enters the scene tree for the first time.
var x = 0
var y = 0

func _ready():
    SignalManager.player_moved.connect(update_region)
    sectors.region_rect = Rect2(Vector2(100,100), Vector2(52,48))
    
    
func update_region(v:Vector2):
    sectors.region_rect = Rect2(v/50-Vector2(26-51, 24-52), Vector2(52,48))
    
