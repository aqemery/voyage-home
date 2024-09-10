extends AnimatedSprite2D

var relic = true

func _on_area_2d_body_entered(body):
    if relic:
        await DialogManager.show_dialog("This appears to be alien ruins!")
        await DialogManager.show_dialog("You send an away party to investigate.")
        relic = false
        Inventory.relics += 1
        print("relic collected")
        if Inventory.relics == 1:
            await DialogManager.show_dialog("Relic collected!\nYou now have 1 relic.")
        else:
            await DialogManager.show_dialog("Relic collected!\nYou now have %s relics." % Inventory.relics)
    else:
        await DialogManager.show_dialog("You already visited these ruins.")
