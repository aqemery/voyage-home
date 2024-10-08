extends AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
    show_dialog()
    

func show_dialog():
    match Inventory.astronomer:
        Inventory.VipState.MISSING:
            await DialogManager.show_dialog("We picked up a distress signal of our team lead in s0-4. Can you please rescue them?")
        Inventory.VipState.FOUND:
            await DialogManager.show_dialog("Astronomer returned.")
            await DialogManager.show_dialog("Thank you for rescuing me. Now I can get back to my work!")
            await DialogManager.show_dialog("We have been researching the alien towers. I believe they are used for navigation.")
            await DialogManager.show_dialog("If we get enought data from them, perhaps we can improve ship sensors...")
            Inventory.astronomer = Inventory.VipState.RETURNED
            await show_dialog()
        Inventory.VipState.RETURNED:
            if Inventory.towers < 4:
                await DialogManager.show_dialog("There are %s more sensor towers to activate before I have enough data for my research." % str(4 - Inventory.towers))
            else:
                await DialogManager.show_dialog("Great you activated all the towers!")
                await DialogManager.show_dialog("Let's upgrade the sensors on your ship.")
                Inventory.astronomer = Inventory.VipState.UPGRADED
        Inventory.VipState.UPGRADED:
            await DialogManager.show_dialog("How are those upgraded sensors treating you?")
    SignalManager.refuel.emit()
