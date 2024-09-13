extends Node

enum VipState { MISSING, FOUND, RETURNED, UPGRADED }

var astronomer: VipState = VipState.MISSING
var engineer: VipState  = VipState.MISSING
var exobiologist: VipState  = VipState.MISSING
var ore = 0
var relics = 0
var towers = 0
