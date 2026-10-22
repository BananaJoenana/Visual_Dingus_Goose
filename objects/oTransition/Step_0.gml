progress += wipe_spd

// Fully black: change rooms, then keep sweeping to reveal the new one
if phase == "cover" and progress >= 1 {
	room_goto(target_room)
	phase = "reveal"
	progress = 0
} else if phase == "reveal" and progress >= 1 {
	oStory.mode = "run"
	instance_destroy()
}
