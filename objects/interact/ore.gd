extends AnimatedSprite2D

@export var id: int
func _on_area_2d_body_entered(body):
    Inventory.ore += 1
    SignalManager.collect_ore.emit(id)
    await DialogManager.show_dialog("Ore collected!\nYou now have %s ore." % Inventory.ore)
    queue_free()
