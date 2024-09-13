extends AnimatedSprite2D

func _on_area_2d_body_entered(body):
    match Inventory.engineer:
        Inventory.VipState.MISSING:
            await DialogManager.show_dialog("Engineer is OOO")
        Inventory.VipState.FOUND:
            await DialogManager.show_dialog("Engineer returned.")
            await DialogManager.show_dialog("Ahh! Feals good to be home! Thank you for rescuing me.")
            Inventory.engineer = Inventory.VipState.RETURNED
        Inventory.VipState.RETURNED:
            if Inventory.ore < 4:
                await DialogManager.show_dialog("I need you to mine %s mor asteroids for ore before I have enough data for my new shields." % str(4-Inventory.ore))
            else:
                await DialogManager.show_dialog("Great you collected all the ore!")
                await DialogManager.show_dialog("Let's upgrade the sheilds on your ship.")
                Inventory.engineer = Inventory.VipState.UPGRADED
        Inventory.VipState.UPGRADED:
            await DialogManager.show_dialog("How are those upgraded sheilds treating you?")
    SignalManager.refuel.emit()
