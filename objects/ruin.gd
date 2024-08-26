extends AnimatedSprite2D

var relic = true

func _on_area_2d_body_entered(body):
    if relic:
        relic = false
        Inventory.relics += 1
        print("relic collected")
