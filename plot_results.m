function plot_results(nsteps,fastmode,noshow)
	
	% PLOT_RESULTS plot the results to the figure
	%
	% nsteps	= number of iterations
	% fastmode	= boolean indicating whether to save video to file 
	
	
	% Use hexagons as markers for hive
	hex = [-sqrt(3)/5 -1/5; 
			0 -2/5;  
			+sqrt(3)/5 -1/5;
			+sqrt(3)/5 +1/5;
			0  2/5;
			-sqrt(3)/5 1/5;
			-sqrt(3)/5 -1/5];

    global N_IT IT_STATS ENV_DATA MESSAGES CONTROL_DATA DISPLAY

	% Calculate remaining time and display
	elapsed_time = etime(clock, IT_STATS.start_time);
	seconds_per_tick = elapsed_time / N_IT;
	time_remaining = seconds_per_tick * (nsteps - N_IT);
	
	time_output = ['Iteration ' num2str(N_IT) '/' num2str(nsteps), ', Time [E: ', num2str(round(elapsed_time,2)), 's, R: ', num2str(round(time_remaining, 2)), 's]'];
	
	disp(time_output);
	if noshow && N_IT<nsteps && N_IT > 1
		return
	end

    %write results to the screen
	num_agents = IT_STATS.num_agents;
	pollen_remaining = IT_STATS.pollen_remaining;
	pollen_at_hive_normal = cumsum(IT_STATS.pollen_at_hive_normal);
	pollen_at_hive_infected = cumsum(IT_STATS.pollen_at_hive_infected);
	pollen_transporting = IT_STATS.pollen_transporting;
	disp(strcat('No. agents = ',num2str(num_agents)));
	disp(strcat('Pollen at Hive (NORM) = ',num2str(pollen_at_hive_normal(N_IT + 1))));
	disp(strcat('Pollen at Hive (INF)  = ',num2str(pollen_at_hive_infected(N_IT + 1))));
	disp(strcat('Pollen Remaining = ',num2str(pollen_remaining(N_IT + 1))));
	disp(strcat('Pollen Transporting = ',num2str(pollen_transporting(N_IT + 1))));
	

    %plot line graphs of agent numbers and remaining food
    if (fastmode==false) || (N_IT>=nsteps) || (N_IT == 1) || ~isempty(IT_STATS.VIDEO_CAPTURE) || ((fastmode==true) && (rem(N_IT , CONTROL_DATA.fmode_display_every)==0))
		
		check_for_figure()
		
        %create plot of agent locations. 	
		subplot(4,1,[1,2,3]);
		imagesc(ENV_DATA.pollen);
		colormap('summer');
		axis('square');
		
        hold on
		
		% Using the MESSAGES.pos system we can iterate over the agents much
		% faster than using the iteration
		agent_positions = MESSAGES.pos(N_IT+1, :, :);
		healthy_agent_positions = permute(agent_positions(:, ~MESSAGES.is_infected, :),[2 3 1]);
		infected_agent_positions = permute(agent_positions(:, ~~MESSAGES.is_infected, :),[2 3 1]);
		
		%Render the healthy agents
		scatter(healthy_agent_positions(:, 1),healthy_agent_positions(:, 2),70,...
			'Marker', 'o',...
			'MarkerEdgeColor', 'k',...
			'LineWidth', 2,...
			'MarkerFaceColor', [1 1 0]);
		
		%Render the infected agents
		scatter(infected_agent_positions(:,1),infected_agent_positions(:,2),70,...
			'Marker', 'o',...
			'MarkerEdgeColor', 'k',...
			'LineWidth', 2,...
			'MarkerFaceColor', [0.8 0 0]);

        %Render the hive
		patch('Faces', [1,2,3,4,5,6],...
			'Vertices', hex+ENV_DATA.hive_location,...
			'FaceColor',[0.9290 0.6940 0.1250],...
			'LineWidth', 2);
					
		hold off
		
		subplot(4,1,4);
		
		h = pollen_at_hive_normal(1:N_IT+1);
		h_i = pollen_at_hive_infected(1:N_IT+1);
		t = pollen_transporting(1:N_IT+1);
		
		y = [h;h_i;t]';
	
		area(0:N_IT, y, 'EdgeAlpha', 0);
		colororder([0.9290 0.6940 0.1250; 0.9290 0.3940 0; 0 0 0]);
		axis([0 nsteps 0 max(max(h)+max(h_i)+max(t),1)]);
		
		legend({'Pollen at Hive (FROM NORMAL)','Pollen at Hive (FROM INFECTED)', 'Pollen Collected'}, 'Location', 'best' );
		
		set(DISPLAY.fig, 'Name', time_output);
        drawnow
		
		% Save the frame for the video
		if ~isempty(IT_STATS.VIDEO_CAPTURE)	
			frame = getframe(DISPLAY.fig);
			f1 = frame2im(frame);
			f2 = imresize(f1, [840, 1120]);
			writeVideo(IT_STATS.VIDEO_CAPTURE, f2);
		end
    end
end
