function is_infected = get_infected(agents)
	
	% GET_INFECTED returns an ordered list of boolean values indicating
	% whether an agent of the same id is infected
	%
	% I = get_infected(A) given a cell array of agents A, returns a logical
	% array indicating the infection status of the agent
	
	n = length(agents);
	is_infected = zeros(n,1);
	
	parfor i=1:n
		agent = agents{i};
		is_infected(i) = agent.is_infected
	end
end