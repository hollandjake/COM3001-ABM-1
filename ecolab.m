function ecolab(size,nr,nf,nsteps,fmode,outImages)

%ECO_LAB  agent-based predator-prey model, developed for
%demonstration purposes only for University of Sheffield module
%COM3001/6006/6009

%AUTHOR Dawn Walker d.c.walker@sheffield.ac.uk
%Created April 2008

%ecolab(size,nr,nf,nsteps)
%size = size of model environmnet in km (sugested value for plotting
%purposes =50)
%nr - initial number of rabbit agents
%nf - initial number of fox agents
%nsteps - number of iterations required

%definition of global variables:
%N_IT - current iteration number
%IT_STATS  -  is data structure containing statistics on model at each
%iteration (number of agents etc). iniitialised in initialise_results.m
%ENV_DATA - data structure representing the environment (initialised in
%create_environment.m)

    %clear any global variables/ close figures from previous simulations
    clear global
    close all

    global N_IT IT_STATS ENV_DATA CONTROL_DATA

    if nargin == 4
        fmode=true;
        outImages=false;
    elseif nargin == 5
        outImages=false;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MODEL INITIALISATION
    create_control;                     %sets up the parameters to control fmode (speed up the code during experimental testing
    create_params;                      %sets the parameters for this simulation
    create_environment(size);           %creates environment data structure, given an environment size
    random_selection(1);                %randomises random number sequence (NOT agent order). If input=0, then simulation should be identical to previous for same initial values
    agents=create_agents(nr,nf);        %create nr rabbit and nf fox agents and places them in a cell array called 'agents'
    create_messages(nr,nf,agents);       %sets up the initial message lists
    initialise_results(nr,nf,nsteps);   %initilaises structure for storing results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %MODEL EXECUTION
    for n_it=1:nsteps                   %the main execution loop
        N_IT=n_it;
        agents=agnt_solve(agents);     %the function which calls the rules
		IT_STATS.pollen_remaining(N_IT+1) = sum(sum(ENV_DATA.pollen));
		IT_STATS.pollen_collected(N_IT+1) = 0;
        plot_results(agents,nsteps,fmode,outImages); %updates results figures and structures
        %mov(n_it)=getframe(fig3);
    end
eval(['save results_nr_' num2str(nr) '_nf_' num2str(nf) '.mat IT_STATS ENV_DATA' ]);
clear global
