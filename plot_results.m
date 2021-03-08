function plot_results(agents, nsteps,fastmode)
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
	persistent start_time, start_time = tic;
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
    if (fastmode==false) || (N_IT>=nsteps) || ~isempty(IT_STATS.VIDEO_CAPTURE) || ((fastmode==true) && (rem(N_IT , CONTROL_DATA.fmode_display_every)==0))
		
		check_for_figure()
		
		elapsed = toc(start_time);
		seconds_per_tick = elapsed/N_IT;
		text(0, 0, num2str(seconds_per_tick * (nsteps - N_IT)));
		
        %create plot of agent locations. 	
		subplot(4,1,[1,2,3]);
% 		im = imagesc(ENV_DATA.pollen);
		im = imresize(ENV_DATA.pollen, [1000, NaN],'nearest');
		imshow(im);
		colormap('summer');
		axis('square');
		
        hold on
		
		bee_img = imread('bee copy.png');
		bee_img = imresize(bee_img, [50,NaN], 'nearest');
		
		agent_positions = MESSAGES.pos(N_IT+1, :, :);


        for cn=1:length(agents)               %cycle through each agent in turn
			pos=[agent_positions(:,cn, 1), agent_positions(:,cn,2)];               %extract current position
			
% 			plot(pos(1),pos(2),...
% 				'Marker', 'o',...
% 				'MarkerSize', 1,...
% 				'MarkerEdgeColor', 'k',...
% 				'LineWidth', 2,...
% 				'MarkerFaceColor', [1 1 0]);
			
			image(pos(1)*100,pos(2)*100,bee_img);
        end
				
		
% 		scatter(agent_positions(:, :,1),agent_positions(:, :,2),70,...
% 			'Marker', 'o',...
% 			'MarkerEdgeColor', 'k',...
% 			'LineWidth', 2,...
% 			'MarkerFaceColor', [1 1 0]);

        %Render the hive
		patch('Faces', [1,2,3,4,5,6],...
			'Vertices', hex+ENV_DATA.hive_location,...
			'FaceColor',[0.9290 0.6940 0.1250],...
			'LineWidth', 2);
					
		hold off
		
		subplot(4,1,4);
		title('Pollen collected');
		y = [pollen_at_hive(1:N_IT+1);pollen_at_hive(1:N_IT+1)+pollen_transporting(1:N_IT+1);ones(1,N_IT+1)*ENV_DATA.total_pollen;]';
		x = 0:N_IT;
		area(x,y, 'EdgeAlpha', 0);
		colororder([0.9290 0.6940 0.1250; 0 0 0; 0.4660 0.6740 0.1880]);
		axis([0 nsteps 0 ENV_DATA.total_pollen]);
		
		set(DISPLAY.fig, 'Name', ['Iteration ' num2str(N_IT) '/' num2str(nsteps)]);
        drawnow
		
		if ~isempty(IT_STATS.VIDEO_CAPTURE)	
			frame = getframe(DISPLAY.fig);
			f1 = frame2im(frame);
			f2 = imresize(f1, [840, 1120]);
			writeVideo(IT_STATS.VIDEO_CAPTURE, f2);
		end
    end
end
