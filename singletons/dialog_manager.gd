extends Node
class_name dialog_manager

const DIALOG = preload("res://dialog.tscn")

func show_dialog(text: String):
    var b = DIALOG.instantiate()
    #call_add_child(b)
    get_tree().root.add_child(b)
    b.display_text(text)
    await b.done
    
func show_dialog_d(text: String):
    var b = DIALOG.instantiate()
    #call_add_child(b)
    get_tree().root.add_child(b)
    b.display_text(text)
    await b.done
    b
    
func add_deferred(scene):
    get_tree().root.add_child(scene)

func call_add_child(scene):
    call_deferred("add_deferred", scene)
