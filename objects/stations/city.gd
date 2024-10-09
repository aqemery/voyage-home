extends AnimatedSprite2D

@export var clues:Array[String] = []
@export var welcome_message = "Welcome to our city!"
@export var welcome_back = "Welcome back! We'll get you filled up."
var first_visit = true

func _on_area_2d_body_entered(body):
    if Inventory.just_died:
        Inventory.just_died = false
        if Inventory.died_cause == Inventory.Cause.FUEL:
            await DialogManager.show_dialog("We found you floating without fuel and towed you here. Keep an eye on your fuel in the future.")
        elif Inventory.died_cause == Inventory.Cause.ENEMY:
            await DialogManager.show_dialog("We found your ship floating in space. It looks like you were attacked by aliens. Be careful out there.")
        elif Inventory.died_cause == Inventory.Cause.NEBULA:
            await DialogManager.show_dialog("We found your ship floating in a nebula. It looks like you got lost in the clouds. Be careful out there.")
        elif Inventory.died_cause == Inventory.Cause.ASTEROID:
            await DialogManager.show_dialog("We found your ship floating in space. It looks like you were hit by an asteroid. Be careful out there.")
        await DialogManager.show_dialog("Warning: Navagation data lost.")
    elif first_visit:
        await DialogManager.show_dialog(welcome_message)
        first_visit = false
    else:
        await DialogManager.show_dialog(welcome_back)
            
    await FuelManager.refuel()
    if clues.size() > 0:
        await DialogManager.show_dialog(clues.pick_random())
    SignalManager.checkpoint.emit()
    Inventory.respawn_pos = global_position
