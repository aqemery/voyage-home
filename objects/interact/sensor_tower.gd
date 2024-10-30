extends AnimatedSprite2D

@export var id: int
var active = false
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_area_2d_body_entered(body):
     if not active:
        Inventory.towers += 1
        audio_stream_player.play()
        
        play("powerup")
        active = true
        SignalManager.activate_tower.emit(id)
        

func _on_animation_finished():
    play("powered")
