extends Node2D
@onready var map_container: SubViewportContainer = $mapContainer
@onready var map_viewport: SubViewport = $mapContainer/mapViewport
@onready var pos: Node2D = $mapContainer/mapViewport/map/positon
@onready var main_container: SubViewportContainer = $mainContainer
@onready var main_viewport: SubViewport = $mainContainer/mainViewport


var map_full = false

    
func _input(event: InputEvent) -> void:
    if event.is_action_pressed("show_minimap"):
        map_full = true
        set_big(map_container, map_viewport)
        set_small(main_container, main_viewport)
    elif event.is_action_released("show_minimap"):
        map_full = false
        set_small(map_container, map_viewport)
        set_big(main_container, main_viewport)
        

func set_small(container: SubViewportContainer, viewport: SubViewport):
    viewport.size = Vector2i(52, 48)
    container.size = Vector2i(52, 48)
    container.position = Vector2(5, 5)
    
func set_big(container: SubViewportContainer, viewport: SubViewport):
    viewport.size = Vector2i(332, 230)
    container.size = Vector2i(332, 230)
    container.position = Vector2(64, 5)
    
    
var origin_f = Vector2(0, -3)
