function create_messages(agents, nsteps)

	% CREATE_MESSAGES initializes the global MESSAGES struct which houses
	% the communication between agents and also provides a useful way of
	% tracking agent positions fast
	%
	% create_messages(A,S) - creates a message stack for the cell array of
	% agents A holding enough size for S steps

	global MESSAGES;
	
	MESSAGES.pos = zeros(nsteps,length(agents),2);
	
	MESSAGES.is_infected = get_infected(agents);

	% MESSAGES.pos - 3D array of positions of each agent per timestep
	MESSAGES.pos(1, :, :) = get_agent_positions(agents);
end