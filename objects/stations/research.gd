extends AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
    show_dialog()

func show_dialog():
    match Inventory.exobiologist:
        Inventory.VipState.MISSING:
            await DialogManager.show_dialog("Our senior exobiologist went out to explore some ruins and hasn't returned.")
            await DialogManager.show_dialog("Would you be able to help us find them?")
        Inventory.VipState.FOUND:
            await DialogManager.show_dialog("Exobiologist returned.")
            await DialogManager.show_dialog("Ahh! Feels good to be home! Thank you for rescuing me.")
            await DialogManager.show_dialog("I have been exploring the alien ruins. I believe they hold the key to understanding the alien language.")
            await DialogManager.show_dialog("If we get enough data from them, perhaps we can understand how to communicate with them.")
            Inventory.exobiologist = Inventory.VipState.RETURNED
            await show_dialog()
        Inventory.VipState.RETURNED:
            if Inventory.relics < 4:
                await DialogManager.show_dialog("There are %s more relics to activate before I have enough data for my translator." % str(4-Inventory.relics))
            else:
                await DialogManager.show_dialog("Great, you collected enough relics!")
                await DialogManager.show_dialog("Let's upgrade the communication array on your ship.")
                await DialogManager.show_dialog("With this upgrade, you will be able to send a friendly signal to the aliens to keep them from attacking your ship.")
                Inventory.exobiologist = Inventory.VipState.UPGRADED
                SignalManager.comms_upgraded.emit()
        Inventory.VipState.UPGRADED:
            await DialogManager.show_dialog("How is the new communication array treating you?")
    SignalManager.refuel.emit()
