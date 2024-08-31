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
            SignalManager.collect_engineer.emit()
        VipType.ASTRONOMER:
            Inventory.astronomer = true
            SignalManager.collect_astronomer.emit()
        VipType.EXOBIOLOGIST:
            Inventory.exobiologist = true
            SignalManager.collect_exobiologist.emit()
    queue_free()
