function check_for_figure()

	% CHECK_FOR_FIGURE Ensures the figure exists 
	%
	% If the figure didnt exist when it tries to
	% render the elements it will error
	
	global DISPLAY;
	if isempty(DISPLAY) || ~ishandle(DISPLAY.fig)
		DISPLAY.fig = figure('NumberTitle','off');
	end
end