extends Node2D

@onready var ship = $level/ship
@onready var camera_2d = $level/Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    camera_2d.position = ship.position
