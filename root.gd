extends Node2D
@onready var map_container: SubViewportContainer = $mapContainer
@onready var map_viewport: SubViewport = $mapContainer/mapViewport
@onready var pos: Node2D = $mapContainer/mapViewport/map/positon
@onready var main_container: SubViewportContainer = $mainContainer
@onready var main_viewport: SubViewport = $mainContainer/mainViewport
@onready var pause_menu: CanvasLayer = %pause_menu

signal map_opened


var map_full = false

func _ready():
    Inventory.reset()
    SignalManager.activate_tower.connect(sensor_activate)
    
    control_intro()
    
    

    
func _input(event: InputEvent) -> void:
    if get_tree().paused:
        return
    if event.is_action_pressed("show_minimap"):
        show_map()
    elif event.is_action_released("show_minimap"):
        hide_map()
        
        
func control_intro():
    await get_tree().create_timer(0.5).timeout
    await DialogManager.show_dialog("We need to head toward that city.")
    await DialogManager.show_dialog("Press and hold the 'Z' key to bring up your map.")
    await map_opened
    await DialogManager.show_dialog("The SS Conveyance's location will show as a blinking dot.")
    await DialogManager.show_dialog("We can't see much arround us. The wormhole is to the northwest, and there is a city to the south east.")
    hide_map()
    await get_tree().create_timer(0.5).timeout
    await DialogManager.show_dialog("Press the left and right arrow key to change the direction of your ship.")
    await DialogManager.show_dialog("Press the 'X' to accelerate. Be careful you can get going pretty fast!")
    await DialogManager.show_dialog("There is a fuel gage on the left side of your screen. Don't forget to keep an eye on how much fuel you are using.")
    await DialogManager.show_dialog("Lets find our way home!")
    
func show_map():
    map_full = true
    set_big(map_container, map_viewport)
    set_small(main_container, main_viewport)
    map_opened.emit()
    
    
func hide_map():
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
    

func sensor_activate(i):
    show_map()
    $mapContainer/mapViewport/map/positon/Camera2D.anchor_mode = 1
    get_tree().paused = true
    $mapContainer/mapViewport/map/SubViewportContainer/SubViewport/fog.expand(sensor_done)

func sensor_done():
    await get_tree().create_timer(1.0).timeout
    get_tree().paused = false
    show_map()
    
    await DialogManager.show_dialog("Sensor tower activated!")
    hide_map()
    $mapContainer/mapViewport/map/positon/Camera2D.anchor_mode = 0
    SignalManager.checkpoint.emit()
    
    
var origin_f = Vector2(0, -3)


func _on_quit_button_pressed() -> void:
    pass # Replace with function body.
