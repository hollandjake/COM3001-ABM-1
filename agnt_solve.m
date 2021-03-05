function [nagent,nn]=agnt_solve(agent)

%sequence of functions called to apply agent rules to current agent population.
%%%%%%%%%%%%
%[nagent,nn]=agnt_solve(agent)
%%%%%%%%%%%
%agent - list of existing agent structures
%nagent - list of updated agent structures
%nn - total number of live agents at end of update

%Created by Dawn Walker 3/4/08 

n=length(agent);    %current no. of agents
n_new=0;    %no. new agents
prev_n=n;   %remember current agent number at the start of this iteration

%execute existing agent update loop
for cn=1:n
	bee=agent{cn};
	if isempty(bee.target)
		bee.target = find_flower(bee, cn);
	end
	
	% If we have a target location
	if ~isempty(bee.target)
		% If bee is ontop of the target (within 2 d.p.)
		if round(bee.pos,2) == bee.target
			bee = collect_pollen(bee, cn);
		else
			bee = move(bee, cn);
		end
	end
	
	agent{cn}=bee;                          %up date cell array with modified agent data structure
end

temp_n=n+n_new; %new agent number (before accounting for agent deaths)
[nagent,nn]=update_messages(agent,prev_n,temp_n);   %function which update message list and 'kills off' dead agents.

