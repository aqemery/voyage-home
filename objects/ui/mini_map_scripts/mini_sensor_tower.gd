extends AnimatedSprite2D

@export var id: int

func _ready() -> void:
    SignalManager.activate_tower.connect(activate_tower)

func activate_tower(activate_id):
    if activate_id == id:
        play("powerup")

func _on_animation_finished():
    play("powered")
