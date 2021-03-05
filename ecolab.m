function ecolab(size, iterations, varargin)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%INPUT PARSING
	
	parser = inputParser;
	addParameter(parser, 'seed', 0, @isnumeric);
	addParameter(parser, 'fastmode', true, @isboolean);
	addParameter(parser, 'save', false, @isboolean);

	parse(parser, varargin{:});
	
	fastmode = parser.Results.fastmode;
	save = parser.Results.save;
	
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

	global ENV, ENV = Environment(size);
	global AGENTS, AGENTS = generateAgents(ENV.HIVE_LOCATION);
	global MESSAGES, MESSAGES = cell(1, PARAMS.NUM_AGENTS);


	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%ITERATION
		
	for i = 1:iterations
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%PROCESSING
		
		%Process environment messages
% 		ENV.process();
		newMessages = cell(1, PARAMS.NUM_AGENTS);
		
		%Process all agent messages
		agentIdMapping = randperm(PARAMS.NUM_AGENTS);
		mixedAgents = AGENTS(agentIdMapping);
		
		parfor index = 1:PARAMS.NUM_AGENTS
			agent = mixedAgents{index};
			[agent, newMessages{index}] = agent.process();
			mixedAgents{index} = agent;
		end
		AGENTS = mixedAgents;
		
		MESSAGES = newMessages;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%RENDERING
		if ~fastmode
			tiledlayout(1,1);
			nexttile
			ENV.render();
			drawnow
			
			if (save)
				if (i==1)
					gif('test.gif','overwrite',true);
				else
					gif
				end
			end
		end
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	
	
	


end