extends AnimatedSprite2D

func _on_area_2d_body_entered(body):
    await DialogManager.show_dialog("Engineer is OOO")
    await FuelManager.refuel()
