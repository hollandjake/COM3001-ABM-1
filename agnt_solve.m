function agents=agnt_solve(agents)

	%sequence of functions called to apply agent rules to current agent population.
	%%%%%%%%%%%%
	%[nagent,nn]=agnt_solve(agent)
	%%%%%%%%%%%
	%agent - list of existing agent structures
	%nagent - list of updated agent structures
	%nn - total number of live agents at end of update

	%Created by Dawn Walker 3/4/08 

	n=length(agents);    %current no. of agents

	%execute existing agent update loop
	for cn=1:n
		bee=agents{cn};
		if isempty(bee.target)
			bee.target = find_flower(bee);
		end

		% If we have a target location
		if ~isempty(bee.target)
			% If bee is ontop of the target (within 2 d.p.)
			if round(bee.pos,2) == bee.target
% 				bee = collect_pollen(bee);
			else
				bee = move(bee);
			end
		end

		agents{cn}=bee;                          %up date cell array with modified agent data structure
	end
end

