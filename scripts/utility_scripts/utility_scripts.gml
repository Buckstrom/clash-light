function resolution_scale(scale) {

	var w = window_get_width();
	var h = window_get_height();

	var cam = view_get_camera(0);

	view_set_wport(0, w);
	view_set_hport(0, h);

	camera_set_view_size(cam, view_wport[0]/scale, view_hport[0]/scale);

	surface_resize(application_surface, w, h);
}

