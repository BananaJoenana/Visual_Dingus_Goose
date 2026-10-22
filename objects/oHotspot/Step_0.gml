// Used up by clicked("...", once)? Stay gone.
if array_contains(global.used_clicks, click) {
	instance_destroy()
	exit
}

hovered = position_meeting(mouse_x, mouse_y, id)

// Clickable only while exploring
if hovered and mouse_check_button_pressed(mb_left) and oStory.mode == "explore" and oStory.ignore_input <= 0 {
	with oStory click_hotspot(other.click, other.id)
}
