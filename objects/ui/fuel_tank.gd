extends AnimatedSprite2D

@onready var tanks = [$"tank-0", $"tank-1", $"tank-2", $"tank-3"]
@onready var connects = [$"connect-1", $"connect-2", $"connect-3"]
var last_call = -1

func _process(delta):
    var fuel = FuelManager.fuel
    if abs(last_call - fuel) < .05:
        return
    
    var i_fuel = min(3, int(fuel))
    connects.map(func(x): x.visible = false)
    tanks.map(func(x): x.play("0"))
    
    for i in range(i_fuel):
        connects[i].visible = true
        
    for i in range(4):
        var f = fuel - i
        
        var t: AnimatedSprite2D = tanks[i]
        var a = str(int(max(min(5, f * 5), 0)))
        
        if t.animation != a:
            #await get_tree().create_timer(0.1).timeout
            t.play(str(a))
            
    last_call = fuel
