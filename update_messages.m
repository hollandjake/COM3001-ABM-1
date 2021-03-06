function [nagent,nn]=update_messages(agent,prev_n,temp_n)

%copy all surviving and new agents in to a new agent list - dead agents
%will be empty structures

%agent - list of existing agents, including those that have died in the
%current iteration
%prev_n - previous number of agents at the start of this iteration
%temp_n - number of existing agents, including those that have died in the
%current iteration
%nagent - list of surviving agents and empty structures
%nn - number of surviving agents

%global variables
%N_IT current iteration no
%IT_STATS data structure for saving model statistics
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
   %    MESSAGES.atype - n x 1 array listing the type of each agent in the model
   %    (1=rabbit, 2-fox, 3=dead agent)
   %    MESSAGES.pos - list of every agent position in [x y]
   %    MESSAGE.dead - n x1 array containing ones for agents that have died
   %    in the current iteration
%ENV_DATA - is a data structure containing information about the model
   %environment

global IT_STATS N_IT ENV_DATA

IT_STATS.pollen_remaining(N_IT+1)=sum(sum(ENV_DATA.pollen));   %total pollen remaining