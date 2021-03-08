function ecolab(size,num_flowers,na,ni,nsteps,varargin)

	%ECO_LAB  agent-based predator-prey model, developed for
	%demonstration purposes only for University of Sheffield module
	%COM3001/6006/6009

	%AUTHOR Dawn Walker d.c.walker@sheffield.ac.uk
	%Created April 2008

	%ecolab(size,nr,nf,nsteps)
	%size = size of model environmnet in km (sugested value for plotting
	%purposes =50)
	%nr - initial number of rabbit agents
	%nf - initial number of fox agents
	%nsteps - number of iterations required

	%definition of global variables:
	%N_IT - current iteration number
	%IT_STATS  -  is data structure containing statistics on model at each
	%iteration (number of agents etc). iniitialised in initialise_results.m
	%ENV_DATA - data structure representing the environment (initialised in
	%create_environment.m)

    %clear any global variables/ close figures from previous simulations
    clear global
    close all

    global N_IT IT_STATS ENV_DATA CONTROL_DATA
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%INPUT PARSING
	
	parser = inputParser;
	addParameter(parser, 'seed', 0, @isnumeric);
	addParameter(parser, 'fastmode', true, @isboolean);
	addParameter(parser, 'savefile', false, @islogical);

	parse(parser, varargin{:});
	
	fastmode = parser.Results.fastmode;
	save_file = parser.Results.savefile;
	
	% Populate the random number generator with the seed
	seed = parser.Results.seed;
	if seed == 0
		rng('shuffle');
		r = rng;
		seed = r.Seed;
	else
		rng(seed);
	end
	disp(['Using seed: "',num2str(seed), '"']);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MODEL INITIALISATION
    create_control;                     %sets up the parameters to control fmode (speed up the code during experimental testing
    create_params(num_flowers);                      %sets the parameters for this simulation
    create_environment(size);           %creates environment data structure, given an environment size
    agents=create_agents(na,ni);        %create nr rabbit and nf fox agents and places them in a cell array called 'agents'
    create_messages(agents, nsteps);	%sets up the initial message lists
    initialise_results(seed,na,ni,nsteps,size,save_file);   %initilaises structure for storing results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MODEL EXECUTION
	
	for n_it=1:nsteps                   %the main execution loop
		N_IT=n_it;
		[agents, collected_pollen]=agnt_solve(agents);     %the function which calls the rules
		IT_STATS.num_agents(N_IT+1) = length(agents);
		IT_STATS.pollen_remaining(N_IT+1) = sum(sum(ENV_DATA.pollen));
		IT_STATS.pollen_transporting(N_IT+1) = collected_pollen;
		IT_STATS.pollen_at_hive(N_IT+1) = 0;
		IT_STATS.pollen_distribution(N_IT+1, :, :) = ENV_DATA.pollen;
		plot_results(nsteps,fastmode); %updates results figures and structures
	end
	
	filename= sprintf("results/seed_%d_tot_%d_inf_%d.mat",seed,na,ni);
	VID = IT_STATS.VIDEO_CAPTURE;
	IT_STATS = rmfield(IT_STATS,'VIDEO_CAPTURE');
	save(filename, 'IT_STATS', 'ENV_DATA');
	IT_STATS.VIDEO_CAPTURE = VID;
	
	if ~isempty(IT_STATS.VIDEO_CAPTURE)
		close(IT_STATS.VIDEO_CAPTURE);
	end
	
	clear global
end
