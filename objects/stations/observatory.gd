extends AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
    match Inventory.astronomer:
        Inventory.VipState.MISSING:
            await DialogManager.show_dialog("Astronomer is OOO")
        Inventory.VipState.FOUND:
            await DialogManager.show_dialog("Astronomer returned.")
            await DialogManager.show_dialog("Ahh! Feals good to be home! Thank you for rescuing me.")
            Inventory.astronomer = Inventory.VipState.RETURNED
        Inventory.VipState.RETURNED:
            if Inventory.towers < 4:
                await DialogManager.show_dialog("There are %s more sensor towers to activate before I have enough data for my research." % str(4-Inventory.towers))
            else:
                await DialogManager.show_dialog("Great you activated all the sensors!")
                await DialogManager.show_dialog("Let's upgrade the sensors on your ship.")
                Inventory.astronomer = Inventory.VipState.UPGRADED
        Inventory.VipState.UPGRADED:
            await DialogManager.show_dialog("How are those upgraded sensors treating you?")
    SignalManager.refuel.emit()
