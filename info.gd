extends Node2D

@onready var label: Label = $Label

@export var speed: int = 30



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    display_text("Wow did you just come out of that wormhole? That's really cool I wish I could go on adventures like you!")
    await SignalManager.low_fuel
    display_text("your fuel is low!")



func display_text(text: String):
    var frequency = 1.0 / speed
    for i in range(text.length()):
        await get_tree().create_timer(frequency).timeout
        label.text = text.substr(0,i+1)
    
    
