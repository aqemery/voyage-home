extends AnimatedSprite2D

func _on_area_2d_body_entered(body):
    await DialogManager.show_dialog("One short day in the emerald city!")
    await FuelManager.refuel()
