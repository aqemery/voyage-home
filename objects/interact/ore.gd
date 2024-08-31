extends AnimatedSprite2D

@export var id: int
func _on_area_2d_body_entered(body):
    Inventory.ore += 1
    SignalManager.collect_ore.emit(id)
    queue_free()
