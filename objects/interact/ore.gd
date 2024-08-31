extends AnimatedSprite2D

func _on_area_2d_body_entered(body):
    Inventory.ore += 1
    queue_free()
