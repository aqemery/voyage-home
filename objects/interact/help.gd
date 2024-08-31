extends AnimatedSprite2D

enum VipType {
    ENGINEER,
    ASTRONOMER,
    EXOBIOLOGIST,
}

@export var vip_type: VipType

func _on_area_2d_body_entered(body):
    match vip_type:
        VipType.ENGINEER:
            Inventory.engineer = true
        VipType.ASTRONOMER:
            Inventory.astronomer = true
        VipType.EXOBIOLOGIST:
            Inventory.exobiologist = true
    prints(vip_type, "collected")
    queue_free()
