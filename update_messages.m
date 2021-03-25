function update_messages(agents)
	
	% UPDATE_MESSAGES updates the global messages for the agents
	%
	% updates the remaining pollen
	% updates the agents positions

global IT_STATS N_IT ENV_DATA MESSAGES

IT_STATS.pollen_remaining(N_IT+1)=sum(sum(ENV_DATA.pollen(1, :, :))); % total pollen remaining

MESSAGES.pos(N_IT+1, :, :) = get_agent_positions(agents);