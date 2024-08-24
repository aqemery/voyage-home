extends Node

const CRUM = preload ("res://objects/bread_crumb.tscn")

func add_deferred(scene):
    get_tree().root.add_child(scene)

func call_add_child(scene):
    call_deferred("add_deferred", scene)

func make_breadcrumb(pos):
    var b = CRUM.instantiate()
    b.global_position = pos
    call_add_child(b)
    print("crumb")
