extends AnimatedSprite2D

enum VipType {
    ENGINEER,
    ASTRONOMER,
    EXOBIOLOGIST,
}


@export var vip_type: VipType


func _on_area_2d_body_entered(body):
    var dialog: PackedStringArray
    match vip_type:
        VipType.ENGINEER:
            Inventory.engineer = Inventory.VipState.FOUND
            SignalManager.collect_engineer.emit()
            dialog = [
                "Thank you for rescuing me! I ran into trouble looking for special ore for a project.",
                "Could please take me back to my construction station in s0-0?\nI will make sure it's worth your while."
            ]
        VipType.ASTRONOMER:
            Inventory.astronomer = Inventory.VipState.FOUND
            SignalManager.collect_astronomer.emit()
            dialog = [
                "Thank you for rescuing me! This is embarrassing, but I got lost while looking for a sensor tower.",
                "I think I took a wrong turn. Could you please take me back to my observation station in s1-4?",
                "I can help you find your way around from there. ",
            ]
            
        VipType.EXOBIOLOGIST:
            Inventory.exobiologist = Inventory.VipState.FOUND
            SignalManager.collect_exobiologist.emit()
            dialog = [
                "Thank you for rescuing me! I was in the middle of a mission to find alien artifacts when I got lost.",
                "Could you please take me back to my research station in s5-2?"
            ]
    for i in range(dialog.size()):
        await DialogManager.show_dialog(dialog[i])
    queue_free()
