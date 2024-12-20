extends Node2D
@onready var map_container: SubViewportContainer = $mapContainer
@onready var map_viewport: SubViewport = $mapContainer/mapViewport
@onready var pos: Node2D = $mapContainer/mapViewport/map/positon
@onready var main_container: SubViewportContainer = $mainContainer
@onready var main_viewport: SubViewport = $mainContainer/mainViewport
@onready var pause_menu: CanvasLayer = %pause_menu

signal map_opened
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var tutorialOn: bool = true 

var map_full = false
var enemy_count = 0

func _ready():
    Inventory.reset()
    SignalManager.activate_tower.connect(sensor_activate)
    SignalManager.enter_enemy.connect(enemy_area_inc)
    SignalManager.leave_enemy.connect(enemy_area_dec)
    
    if tutorialOn:
        control_intro()
    


func enemy_area_inc():
    if enemy_count == 0:
        animation_player.play("enemy_range")
    enemy_count += 1
    prints("enemy count", enemy_count)
    
    
func enemy_area_dec():
    enemy_count -= 1
    if enemy_count == 0:
        animation_player.play("enemy_leave")
    prints("enemy count", enemy_count)
    
    

    
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
    await DialogManager.show_dialog("Press and hold the 'Z' key to bring up your map.", "show_minimap")
    await map_opened
    await DialogManager.show_dialog("The SS Conveyance's location will show as a blinking dot.")
    await DialogManager.show_dialog("We can't see much around us. The wormhole is to the northwest, and there is a city to the southeast.")
    hide_map()
    await get_tree().create_timer(0.5).timeout
    await DialogManager.show_dialog("Press the left and right arrow keys to change the direction of your ship.")
    await DialogManager.show_dialog("Press the 'X' to accelerate. Be careful - you can get going pretty fast!")
    await DialogManager.show_dialog("There is a fuel gauge on the left side of your screen. Don't forget to keep an eye on how much fuel you are using.")
    await DialogManager.show_dialog("Let's find our way home!")
    
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
