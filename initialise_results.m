function initialise_results(nr,ni,nsteps)

 global  IT_STATS ENV_DATA 
 
%set up data structure to record statistics for each model iteration
%IT_STATS  -  is data structure containing statistics on model at each
%iteration (number of agents etc)
%ENV_DATA - data structure representing the environment 
 
 IT_STATS=struct('num_agents',zeros(1,nsteps+1),...			% total no. agents in model per iteration
                 'pollen_remaining',zeros(1,nsteps+1),...	% remaining pollen level
				 'pollen_collected',zeros(1,nsteps+1));
            
 
 tf=sum(sum(ENV_DATA.pollen));            %remaining food is summed over all squares in the environment
 IT_STATS.num_agents(1)=nr+ni;
 IT_STATS.pollen_remaining(1)=tf;
 IT_STATS.pollen_collected(1)=0;
