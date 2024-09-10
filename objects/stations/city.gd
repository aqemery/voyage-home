extends AnimatedSprite2D

@export var clues:Array[String] = []
@export var welcome_message = "Welcome to our city!"
@export var welcome_back = "Welcome back! We'll get you filled up."
var first_visit = true

func _on_area_2d_body_entered(body):
    if first_visit:
        await DialogManager.show_dialog(welcome_message)
        first_visit = false
    else:
        await DialogManager.show_dialog(welcome_back)
            
    await FuelManager.refuel()
    if clues.size() > 0:
        await DialogManager.show_dialog(clues.pick_random())
