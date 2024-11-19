extends CanvasLayer

@onready var master: HSlider = %master
@onready var sfx: HSlider = %sfx
@onready var music: HSlider = %music
@onready var menu_button: MenuButton = %MenuButton


var before_paused = false
func _ready() -> void:
    master.value = db_to_linear(AudioServer.get_bus_volume_db(0))
    sfx.value = db_to_linear(AudioServer.get_bus_volume_db(1))
    music.value = db_to_linear(AudioServer.get_bus_volume_db(1))
    menu_button.get_popup().id_pressed.connect(_on_menu_button_pressed)

func _input(event: InputEvent) -> void:
    if event.is_action_released("esc"):
        toggle()
            
func toggle():
        if visible:
            visible = false
            get_tree().paused = before_paused
            Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
        else:
            before_paused = get_tree().paused 
            visible = true
            get_tree().paused = true
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
            master.grab_focus()
            
        
func _on_quit_button_pressed() -> void:
    get_tree().quit()

func _on_master_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_sfx_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_music_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(2, linear_to_db(value))


func _on_menu_button_pressed(id : int) -> void:
    match id:
        0: 
            menu_button.text = "Fullscreen"
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
            pass
            
        1: 
            menu_button.text = "Windowed"
            DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_save_pressed() -> void:
   toggle()
