extends CanvasLayer

@onready var master: HSlider = %master
@onready var sfx: HSlider = %sfx
@onready var music: HSlider = %music

func _ready() -> void:
    master.value = db_to_linear(AudioServer.get_bus_volume_db(0))
    sfx.value = db_to_linear(AudioServer.get_bus_volume_db(1))
    music.value = db_to_linear(AudioServer.get_bus_volume_db(1))

func _input(event: InputEvent) -> void:
    if event.is_action_released("esc"):
        visible = !visible
        get_tree().paused = !get_tree().paused
        if get_tree().paused:
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
        else:
            Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_quit_button_pressed() -> void:
    get_tree().quit()

func _on_master_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(0, linear_to_db(value))

func _on_sfx_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_music_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(2, linear_to_db(value))
