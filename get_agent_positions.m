function positions = get_agent_positions(agents)
	n = length(agents);
	positions = zeros(n,2);
	
	parfor i=1:n
		positions(i,:) = agents{i}.pos;
	end
end