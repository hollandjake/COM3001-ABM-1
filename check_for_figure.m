function check_for_figure()
	global DISPLAY;
	if isempty(DISPLAY) || ~ishandle(DISPLAY.fig)
		DISPLAY.fig = figure('NumberTitle','off');
		DISPLAY.position = get(DISPLAY.fig, 'Position');
	end
end