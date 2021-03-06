function plot_results(agent,nsteps,fastmode)
	% Use hexagons as markers for hive
	hex = [-sqrt(3)/5 -1/5; 
			0 -2/5;  
			+sqrt(3)/5 -1/5;
			+sqrt(3)/5 +1/5;
			0  2/5;
			-sqrt(3)/5 1/5;
			-sqrt(3)/5 -1/5];

    %Plots 2d patch images of agents onto background 
    %%%%%%%%%%%
    %plot_results(agent,nr,nf)
    %%%%%%%%%%%
    %agent - current list of agent structures
    %nr -  no. rabbits
    %nf -  no. rabbits

    % Modified by D Walker 3/4/08

    global N_IT IT_STATS ENV_DATA MESSAGES CONTROL_DATA DISPLAY
    %declare variables that can be seen by all functions
    %N_IT is current iteration number
    %ENV_DATA - data structure representing the environment (initialised in
    %create_environment.m)
    %IT_STATS is data structure containing statistics on model at each
    %iteration (no. agents etc)
    %MESSAGES is a data structure containing information that agents need to
    %broadcast to each other

    %write results to the screen
	num_agents = IT_STATS.num_agents(N_IT + 1);
	pollen_remaining = IT_STATS.pollen_remaining;
	pollen_at_hive = IT_STATS.pollen_at_hive;
	pollen_transporting = IT_STATS.pollen_transporting;
    disp(strcat('Iteration = ',num2str(N_IT + 1)));
	disp(strcat('No. agents = ',num2str(num_agents)));
	disp(strcat('Pollen at Hive = ',num2str(pollen_at_hive(N_IT + 1))));
	disp(strcat('Pollen Remaining = ',num2str(pollen_remaining(N_IT + 1))));
	disp(strcat('Pollen Transporting = ',num2str(pollen_transporting(N_IT + 1))));



    %plot line graphs of agent numbers and remaining food
    if (fastmode==false) || (N_IT>=nsteps) || ((fastmode==true) && (rem(N_IT , CONTROL_DATA.fmode_display_every)==0))
		
		check_for_figure()
			
		% progress bar
		ax0 = axes( ...
            'Position', [0 0 1 0.02], ...
            'XLim', [0 1], ...
            'YLim', [0 1], ...
            'Box', 'on', ...
            'ytick', [], ...
            'xtick', [] );
		
		patch(...
			[0, N_IT/nsteps, N_IT/nsteps, 0], ...
			[0 0 1 1],...
			'red');
		
		axtoolbar(ax0);


        col{1}='y-';                   %set up colours that will represent different cell types yellow for collected pollen, green for remaining pollen
        col{2}='g-';
		
        %create plot of agent locations. 	
		ax1 = subplot(4,1,[1,2,3]);
		imagesc(ENV_DATA.pollen);
		colormap('summer');
		axis('square');

		
        hold on

        for cn=1:length(agent)               %cycle through each agent in turn
			pos=agent{cn}.pos;               %extract current position
			plot(pos(1),pos(2),...
				'Marker', 'o',...
				'MarkerSize', 10,...
				'MarkerEdgeColor', 'k',...
				'LineWidth', 2,...
				'MarkerFaceColor', [1 1 0]);
        end

        %Render the hive
		hive = patch('Faces', [1,2,3,4,5,6],...
			'Vertices', hex+ENV_DATA.hive_location,...
			'FaceColor',[0.9290 0.6940 0.1250],...
			'LineWidth', 2);
		
		axtoolbar(ax1,{'zoomin','zoomout','restoreview','datacursor'});
			
		hold off
		
		ax2 = subplot(4,1,4);
		title('Pollen collected');
		y = [pollen_at_hive(1:N_IT+1);pollen_at_hive(1:N_IT+1)+pollen_transporting(1:N_IT+1);ones(1,N_IT+1)*ENV_DATA.total_pollen;]';
		x = 0:N_IT;
		area(x,y, 'EdgeAlpha', 0);
		colororder([0.9290 0.6940 0.1250; 0 0 0; 0.4660 0.6740 0.1880]);
		axis([0 nsteps 0 ENV_DATA.total_pollen]);
		axtoolbar(ax2, {'zoomin','zoomout','restoreview', 'datacursor'});

		
		set(DISPLAY.fig, 'Name', ['Iteration ' num2str(N_IT) '/' num2str(nsteps)]);
        drawnow
		
		if ~isempty(IT_STATS.VIDEO_CAPTURE)	
			frame = getframe(DISPLAY.fig);
			writeVideo(IT_STATS.VIDEO_CAPTURE, frame);
		end
    end
end
