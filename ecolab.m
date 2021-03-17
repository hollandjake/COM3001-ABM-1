function ecolab(size,num_flowers,na,ni,nsteps,varargin)

	% ECOLAB runs a simulation of the bee foraging model
	%
	% ARGUMENTS
	%	size				Size of the grid - it will be size x size
	%
	%	num_flowers			Number of flowers
	%
	%	number_of_agents	Number of bees
	%
	%	number_of_infected	Number of bees infected
	%
	%	number_of_steps		Number of iterations
	%
	% OPTIONAL ARGUMENTS
	%	'seed'				Random number used for seeding the randomiser
	%
	%	'fastmode'			Skip some rendering to speed up processing (is disabled if savefile is enabled)
	%
	%	'savefile'			Save an mp4 of the figure
	%
	% e.g. ecolab(10, 25, 10, 2, 100, 'seed', 5, 'fastmode', true) will run
	% a simulation on a 10x10 grid with 25 flowers, it will have 10 healthy
	% agents and 2 infected agents, the simulation will run for 100
	% iterations and will be initialised with the seed, '5', it will skip
	% some rendering frames in order to speed up the simulation
	% approximate runtime is 14 seconds
	
	
    clear global
    close all

    global N_IT IT_STATS ENV_DATA CONTROL_DATA
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%INPUT PARSING
	
	parser = inputParser;
	addParameter(parser, 'seed', 0, @isnumeric);
	addParameter(parser, 'fastmode', true, @islogical);
	addParameter(parser, 'savefile', false, @islogical);
	addParameter(parser, 'noshow', false, @islogical);


	parse(parser, varargin{:});
	
	fastmode = parser.Results.fastmode;
	save_file = parser.Results.savefile;
	noshow = parser.Results.noshow;
	
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
    initialise_results(seed,na,ni,nsteps,size,save_file, noshow);   %initilaises structure for storing results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MODEL EXECUTION
	
	for n_it=1:nsteps                   %the main execution loop
		N_IT=n_it;
		[agents, collected_pollen]=agnt_solve(agents);     %the function which calls the rules
		IT_STATS.num_agents(N_IT+1) = length(agents);
		IT_STATS.pollen_remaining(N_IT+1) = sum(sum(ENV_DATA.pollen));
		IT_STATS.pollen_transporting(N_IT+1) = collected_pollen;
		IT_STATS.pollen_distribution(N_IT+1, :, :) = ENV_DATA.pollen;
		plot_results(nsteps,fastmode, noshow); %updates results figures and structures
	end
	
	if ~isempty(IT_STATS.VIDEO_CAPTURE)
		VID = IT_STATS.VIDEO_CAPTURE;
		close(VID);
	end
	
	filename= sprintf("results/seed_%d_tot_%d_inf_%d.mat",seed,na,ni);
	IT_STATS = rmfield(IT_STATS,'VIDEO_CAPTURE');
	save(filename, 'IT_STATS', 'ENV_DATA');
	
	clear global
end
