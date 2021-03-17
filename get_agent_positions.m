function positions = get_agent_positions(agents)

	% GET_AGENT_POSITIONS returns all the agent positions as an array
	
	n = length(agents);
	positions = zeros(n,2);
	
	for i=1:n
		positions(i,:) = agents{i}.pos;
	end
end