function initialise_results(seed,na,ni,nsteps,size,save_file)

	global  IT_STATS ENV_DATA 

	%set up data structure to record statistics for each model iteration
	%IT_STATS  -  is data structure containing statistics on model at each
	%iteration (number of agents etc)
	%ENV_DATA - data structure representing the environment 

	IT_STATS=struct('num_agents',zeros(1,nsteps+1),...			% total no. agents in model per iteration
					 'pollen_remaining',zeros(1,nsteps+1),...	% remaining pollen level
					 'pollen_at_hive',zeros(1,nsteps+1),...
					 'pollen_transporting', zeros(1,nsteps+1),...
					 'pollen_distribution', zeros(nsteps+1,size,size),...
					 'agents', zeros(nsteps+1,na));


	tf=sum(sum(ENV_DATA.pollen));            %remaining food is summed over all squares in the environment
	IT_STATS.num_agents(1)=na+ni;
	IT_STATS.pollen_remaining(1)=tf;
	IT_STATS.pollen_at_hive(1)=0;
	IT_STATS.pollen_transporting(1) = 0;
	IT_STATS.pollen_distribution(1, :, :) = ENV_DATA.pollen;


	if save_file
		filename = sprintf("results/seed_%d_tot_%d_inf_%d",seed,na,ni);
		IT_STATS.VIDEO_CAPTURE = VideoWriter(filename, 'MPEG-4');
		IT_STATS.VIDEO_CAPTURE.FrameRate = 10;
		open(IT_STATS.VIDEO_CAPTURE);
	else
		IT_STATS.VIDEO_CAPTURE = [];
	end
end