extends Node2D
class_name Dialog

@onready var label: Label = $Label
@onready var next: AnimatedSprite2D = $next
@export var speed: int = 30
@onready var wave: ColorRect = $wave

signal done
var can_next = false 


func _input(event):
    if can_next and event.is_action_pressed("fire"):
        get_tree().paused = false
        done.emit()
        queue_free()


func display_text(text: String):
    get_tree().paused = true
    wave.material.set("shader_parameter/amplitude",  0.9);
    var frequency = 1.0 / speed
    for i in range(text.length()):
        await get_tree().create_timer(frequency).timeout
        label.text = text.substr(0,i+1)
    next.show()
    
    var amp = 0.9
    for i in range(8):
        amp -= 0.1
        wave.material.set("shader_parameter/amplitude",  amp);
        await get_tree().create_timer(frequency).timeout
    can_next = true
    print("can next")
    
    
    
