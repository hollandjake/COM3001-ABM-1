function create_messages(agents, nsteps)

	%function that populates the global data structure representing
	%message information

	%MESSAGES is a data structure containing information that agents need to
	%broadcast to each other
	%    MESSAGES.atype - n x 1 array listing the type of each agent in the model
	%    (1=rabbit, 2-fox, 3=dead agent)
	%    MESSAGES.pos - list of every agent position in [x y]
	%    MESSAGE.dead - n x1 array containing ones for agents that have died
	%    in the current iteration

	global MESSAGES;
	
	MESSAGES.pos = zeros(nsteps,length(agents),2);

	% MESSAGES.pos - 3D array of positions of each agent per timestep

	MESSAGES.pos(1, :, :) = get_agent_positions(agents);
end
     
