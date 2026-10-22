var _w = display_get_gui_width()
var _h = display_get_gui_height()
draw_set_color(c_black)
if phase == "cover" {
	draw_rectangle(0, 0, _w * progress, _h, false)
} else {
	draw_rectangle(_w * progress, 0, _w, _h, false)
}
