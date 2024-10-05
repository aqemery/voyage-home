extends AnimatedSprite2D

func _on_area_2d_body_entered(body):
    show_dialog()
    
func show_dialog():
    match Inventory.engineer:
        Inventory.VipState.MISSING:
            await DialogManager.show_dialog("Our lead Engineer is missing! Could you help us find them?")
        Inventory.VipState.FOUND:
            await DialogManager.show_dialog("Engineer returned.")
            await DialogManager.show_dialog("Ahh! Feals good to be home! Thank you for rescuing me.")
            await DialogManager.show_dialog("I was trying to collect ore for a new sheild I am designing.")
            await DialogManager.show_dialog("If you can help collect ore for us, we should be able to upgrade your ship.")
            Inventory.engineer = Inventory.VipState.RETURNED
            await show_dialog()
        Inventory.VipState.RETURNED:
            if Inventory.ore < 4:
                await DialogManager.show_dialog("I need you to mine %s more asteroids for ore before we have enough for our new shields." % str(4-Inventory.ore))
            else:
                await DialogManager.show_dialog("Great you collected all the ore!")
                await DialogManager.show_dialog("Let's upgrade the sheilds on your ship.")
                Inventory.engineer = Inventory.VipState.UPGRADED
        Inventory.VipState.UPGRADED:
            await DialogManager.show_dialog("How are those upgraded sheilds treating you?")
    SignalManager.refuel.emit()
