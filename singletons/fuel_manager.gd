extends Node
class_name fuel_manager

var fuel = 2
var fuel_can_warn = true

func _ready():
    SignalManager.refuel.connect(refuel)

func _physics_process(delta):
    if fuel_can_warn and fuel < 1:
        SignalManager.low_fuel.emit()
        fuel_can_warn = false
        
func refuel():
    fuel = 4
    await DialogManager.show_dialog("Fuel refilled!").done
    fuel_can_warn = true
    
        
