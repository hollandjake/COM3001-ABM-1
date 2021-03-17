function initialise_results(seed,num_agents,num_infected,nsteps,size,save_file,noshow)

	% INITIALISE_RESULTS initialises the IT_STATS global which is
	% responsible for tracking the history of the simulation
	%
	%	seed			= value used for random values
	%	num_agents		= number of healthy agents
	%	num_infected	= number of infected agents
	%	nsteps			= number of iterations
	%	save_file		= boolean indicating whether to save the video

	global  IT_STATS ENV_DATA 

	IT_STATS=struct('num_agents',zeros(1,nsteps+1),...						% total no. agents in model per iteration
					 'pollen_remaining',zeros(1,nsteps+1),...				% remaining pollen level
					 'pollen_at_hive_normal',zeros(1,nsteps+1),...			% pollen which has been brought back to the hive
					 'pollen_at_hive_infected',zeros(1,nsteps+1),...		% pollen which has been brought back to the hive
					 'pollen_transporting', zeros(1,nsteps+1),...			% pollen attached to agents
					 'pollen_distribution', zeros(nsteps+1,size,size),...	% distribution of pollen over time
					 'agents', zeros(nsteps+1,num_agents));					% list of agents

	tf=sum(sum(ENV_DATA.pollen));  %remaining pollen is summed over all squares in the environment
	IT_STATS.num_agents(1)=num_agents+num_infected;
	IT_STATS.pollen_remaining(1)=tf;
	IT_STATS.pollen_distribution(1, :, :) = ENV_DATA.pollen;


	if save_file && ~noshow
		if ~exist("results/", 'dir')
		   mkdir("results/")
		end
		filename = sprintf("results/seed_%d_tot_%d_inf_%d",seed,num_agents,num_infected);
		IT_STATS.VIDEO_CAPTURE = VideoWriter(filename, 'MPEG-4');
		IT_STATS.VIDEO_CAPTURE.FrameRate = 10;
		open(IT_STATS.VIDEO_CAPTURE);
	else
		IT_STATS.VIDEO_CAPTURE = [];
	end
end