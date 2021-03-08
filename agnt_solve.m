function [agents, total_collected_pollen] = agnt_solve(agents)

	% AGNT_SOLVE Apply the rules to the agents
	%
	%	[A, C] = agnt_solve(A) given a cell array of agents A it will return
	%	the modified agents A and the total collected pollen C
	%

	n=length(agents); %current no. of agents
	total_collected_pollen = zeros(1, n);

	%execute existing agent update loop
	for cn=1:n
		bee=agents{cn};
		
		% If bee doesnt have a target then try to find a flower
		if isempty(bee.target)
			bee.target = find_flower(bee);
		end

		should_move = true;
		
		% If we have a target location
		if ~isempty(bee.target)
			% If bee is ontop of the target (within 2 d.p.)
			if round(bee.pos,2) == bee.target
				% Collect pollen from the flower
				[bee, collected_pollen] = collect_pollen(bee);
				
				% If it didnt collect any pollen then it should move
				if collected_pollen > 0
					should_move = false;
				else
					% remove target so it can wonder around looking for 
					% new flower
					bee.target = [];
					should_move = true;
				end
			end
		end
		
		if should_move
			bee = move(bee);
		end
		
		% add the collected pollen to the total pollen for this iteration
		total_collected_pollen(cn) = bee.collected_pollen; 
		agents{cn}=bee; % update cell array with modified agent data structure
	end
	
	total_collected_pollen = sum(total_collected_pollen);
	
	% Update the messages so the system can process them
	update_messages(agents);
end

