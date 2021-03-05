function [agent]=create_agents(nb,ni)

 %creates the objects representing each agent
 
%agent - cell array containing list of objects representing agents
%nr - number of rabbits
%nf - number of foxes

%global parameters
%ENV_DATA - data structure representing the environment (initialised in
%create_environment.m)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation
 
global ENV_DATA MESSAGES PARAM 
  
bm_size=ENV_DATA.bm_size;
hloc=ENV_DATA.hive_location.*ones(bm_size,1);      %generate random initial positions for rabbits
iloc=ENV_DATA.hive_location.*ones(bm_size,1);      %generate random initial positions for foxes

MESSAGES.pos=[hloc;iloc];

%generate all health bee agents and record their positions in ENV_MAT_R
agent = cell(nb+ni);
for r=1:nb
    pos=hloc(r,:);
    agent{r}=bee(pos,false);
end

%generate all infected bee agents and record their positions in ENV_MAT_F
for f=nb+1:nb+ni
    pos=iloc(f-nb,:);
    agent{f}=bee(pos,true);
end
