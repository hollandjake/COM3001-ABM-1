function [agents, total_collected_pollen] = agnt_solve(agents)

	%sequence of functions called to apply agent rules to current agent population.
	%%%%%%%%%%%%
	%[nagent,nn]=agnt_solve(agent)
	%%%%%%%%%%%
	%agent - list of existing agent structures
	%nagent - list of updated agent structures
	%nn - total number of live agents at end of update

	%Created by Dawn Walker 3/4/08 

	n=length(agents);    %current no. of agents
	total_collected_pollen = zeros(1, n);

	%execute existing agent update loop
	for cn=1:n
		bee=agents{cn};
		if isempty(bee.target)
			bee.target = find_flower(bee);
		end

		% If we have a target location
		should_move = true;
		if ~isempty(bee.target)
			% If bee is ontop of the target (within 2 d.p.)
			if round(bee.pos,2) == bee.target
				[bee, collected_pollen] = collect_pollen(bee);
				if collected_pollen > 0
					should_move = false;
				else
					bee.target = [];
					should_move = true;
				end
			end
		end
		
		if should_move
			bee = move(bee);
		end
		
		total_collected_pollen(cn) = bee.collected_pollen; 
		agents{cn}=bee;                          %up date cell array with modified agent data structure
	end
	
	total_collected_pollen = sum(total_collected_pollen);
	
	update_messages(agents);
end

