extends AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
    match Inventory.exobiologist:
        Inventory.VipState.MISSING:
            await DialogManager.show_dialog("Exobiologist is OOO")
        Inventory.VipState.FOUND:
            await DialogManager.show_dialog("Exobiologist returned.")
            await DialogManager.show_dialog("Ahh! Feals good to be home! Thank you for rescuing me.")
            Inventory.exobiologist = Inventory.VipState.RETURNED
        Inventory.VipState.RETURNED:
            if Inventory.relics < 4:
                await DialogManager.show_dialog("There are %s more relics to activate before I have enough data for my translator" % str(4-Inventory.relics))
            else:
                await DialogManager.show_dialog("Great you collected enough relics!")
                await DialogManager.show_dialog("Let's upgrade the communcation array on your ship.")
                Inventory.exobiologist = Inventory.VipState.UPGRADED
                SignalManager.comms_upgraded.emit()
        Inventory.VipState.UPGRADED:
            await DialogManager.show_dialog("How is the new communcation array treating you?")
    SignalManager.refuel.emit()
