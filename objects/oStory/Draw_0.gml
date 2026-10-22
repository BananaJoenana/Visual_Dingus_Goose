// Characters: everyone else first, then the speaker in front
var _dx = 0
var _dy = 0
if shake_timer > 0 {
	_dx = random_range(-shake_amount, shake_amount)
	_dy = random_range(-shake_amount, shake_amount)
}
for (var i = 0; i < array_length(stage); i++) {
	if stage[i].name != speaker draw_actor(stage[i], _dx, _dy)
}
for (var i = 0; i < array_length(stage); i++) {
	if stage[i].name == speaker draw_actor(stage[i], _dx, _dy)
}
