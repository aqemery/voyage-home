extends AnimatedSprite2D

enum VipType { 
    engineer,
    astronomer,
    exobiologist
}

@export var vip_type:VipType

func _on_area_2d_body_entered(body):
    match vip_type:
        VipType.engineer:
            Inventory.engineer = true
        VipType.astronomer:
            Inventory.astronomer = true
        VipType.exobiologist:
            Inventory.exobiologist = true
    prints(vip_type, "collected")
    queue_free()
