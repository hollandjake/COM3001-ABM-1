function ecolab(size, iterations, varargin)
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%INPUT PARSING
	
	parser = inputParser;
	addParameter(parser, 'seed', 0, @isnumeric);
	parse(parser, varargin{:});
	
	% Populate the random number generator with the seed
	seed = parser.Results.seed;
	if seed == 0
		rng('shuffle');
	else
		rng(seed);
	end

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
		ENV.process();
		newMessages = cell(1, PARAMS.NUM_AGENTS);
		
		%Process all agent messages
		agentIdMapping = randperm(PARAMS.NUM_AGENTS);
		parfor agentIndex = 1:PARAMS.NUM_AGENTS
			agentId = agentIdMapping(agentIndex);			
			agent = AGENTS{agentId};
% 			newMessages{agentIndex} = agent.process();
			disp(agent.ID);
		end
		
		MESSAGES = newMessages;
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%RENDERING
		tiledlayout(1,1);
		nexttile
		env.render();
	end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	
	
	


end