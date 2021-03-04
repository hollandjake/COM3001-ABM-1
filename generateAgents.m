function agents = generateAgents(hiveLocation)
	% generateAgents will create and initialise agents
	
	if PARAMS.INFECTED_AGENTS > PARAMS.NUM_AGENTS
		error('Number of infected agents is greater than the total number of agents');
	end
	
	agents = cell(1, PARAMS.NUM_AGENTS);
	
	% Create Infected agents
	for i = 1:PARAMS.INFECTED_AGENTS
		agents{i} = Bee(i, hiveLocation, true);
	end
	
	% Create Healthy agents
	for i = PARAMS.INFECTED_AGENTS+1:PARAMS.NUM_AGENTS
		agents{i} = Bee(i, hiveLocation, false);
	end
end

