function positions = get_agent_positions(agents)

	% GET_AGENT_POSITIONS returns all the agent positions as an array
	
	n = length(agents);
	positions = zeros(n,2);
	
	parfor i=1:n
		agent = agents{i};
		positions(i,:) = agent.pos;
	end
end