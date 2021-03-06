function plot_results(agent,nsteps,fmode,outImages)
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
	num_agents = IT_STATS.num_agents(N_IT+1);
	pollen_remaining = IT_STATS.pollen_remaining;
	pollen_collected = IT_STATS.pollen_collected;
    disp(strcat('Iteration = ',num2str(N_IT)));
	disp(strcat('No. agents = ',num2str(num_agents)));
	disp(strcat('Pollen Collected = ',num2str(pollen_collected(N_IT+1))));
	disp(strcat('Pollen Remaining = ',num2str(pollen_remaining(N_IT+1))));


    %plot line graphs of agent numbers and remaining food
    if (fmode==false) || (N_IT==nsteps) || ((fmode==true) && (rem(N_IT , CONTROL_DATA.fmode_display_every)==0))
		
		check_for_figure()
		
		% progress bar
		axes( ...
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

        col{1}='y-';                   %set up colours that will represent different cell types yellow for collected pollen, green for remaining pollen
        col{2}='g-';
		
        %create plot of agent locations. 	
		subplot(2,2,[1,3])
		imagesc(ENV_DATA.pollen);
		colormap('summer');
		axis('square');
		axes


		
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
		
		hold off
		
		subplot(2,2,2)
		subplot(2,2,2),title('Pollen collected');
        subplot(2,2,2),plot((1:N_IT+1),pollen_collected(1:N_IT+1),col{1}, 'LineWidth', 2);
		subplot(2,2,2),axis([0 nsteps 0 ENV_DATA.total_pollen]);
		
        subplot(2,2,4)
		subplot(2,2,4),title('Pollen remaining');
        subplot(2,2,4),plot((1:N_IT+1),pollen_remaining(1:N_IT+1),col{2}, 'LineWidth', 2);	
		subplot(2,2,4),axis([0 nsteps 0 ENV_DATA.total_pollen]);
		
% 		waitbarWithPauseButton();

%         uicontrol('Style','pushbutton',...
%                   'String','PAUSE',...
%                   'Position',[20 20 60 20], ...
%                   'Callback', 'global CONTROL_DATA; CONTROL_DATA.pause=true;'); 
% 
%         while CONTROL_DATA.pause==true    % pause/resume functionality - allows pan and zoom during pause...			
% 			text(0, 0, 'PAUSED', 'Color', 'r');
% 			set(DISPLAY.fig, 'Name', ['Iteration no.= ' num2str(N_IT)]);
% 
%             uicontrol('Style','pushbutton',...
%                       'String','RESUME',...
%                       'Position',[20 20 60 20], ...
%                       'Callback', 'global CONTROL_DATA; CONTROL_DATA.pause=false;'); 
% 			drawnow
%         end
		set(DISPLAY.fig, 'Name', ['Iteration ' num2str(N_IT) '/' num2str(nsteps)]);
        drawnow
    end
end
