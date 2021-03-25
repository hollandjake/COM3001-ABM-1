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
		bee=agents{cn}.update();
		
		% add the pollen to the total pollen for this iteration
		total_collected_pollen(cn) = bee.collected_pollen; 
		agents{cn}=bee; % update cell array with modified agent data structure
	end
	
	total_collected_pollen = sum(total_collected_pollen);
	
	% Update the messages so the system can process them
	update_messages(agents);
end

