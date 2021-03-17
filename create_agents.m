function agents=create_agents(num_agents,num_infected)

	% CREATE_AGENTS Creates and initializes the agents
	%
	% A = create_agents(NA,NI) Creates NA+NI agents where NI of the agents
	% will be infected and the rest, NI, will be normal agents
 
global ENV_DATA MESSAGES PARAM 
  
tot_agents = num_agents+num_infected;
positions=ENV_DATA.hive_location.*ones(tot_agents,1); %generate initial positions for agents

MESSAGES.pos=positions;

agents = cell(tot_agents);


%generate all infected bee agents
for i=num_agents+1:tot_agents
    pos=positions(i,:);
    agents{i}=bee(pos,true);
end

%generate all health bee agents
for i=1:num_agents
    pos=positions(i,:);
    agents{i}=bee(pos,false);
end
