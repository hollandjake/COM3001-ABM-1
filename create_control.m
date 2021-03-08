function create_control ()

	% CREATE_CONTROL Initializes the globals for controlling the gui

	global CONTROL_DATA

	CONTROL_DATA.fmode_display_every = 3;
	CONTROL_DATA.fmode_control =[500 1000 2000 4000 8000 ; 4 8 15 30 60];
	CONTROL_DATA.pause = false;

end

